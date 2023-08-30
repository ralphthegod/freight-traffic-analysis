import json
from random import random
import pandas as pd
import time
from utils import street_to_coords, get_docs_from_csv
import os

dataset_dir = "./datasets"

cities = []

#find json but in subdirectory
for subdir, dirs, files in os.walk(dataset_dir):
    if subdir == dataset_dir:
        continue
    for file_name in files:
        file_path = os.path.join(subdir, file_name)
        if os.path.isfile(file_path) and file_name.endswith('.json'):
            cities.append({"name": file_name[:-5], "data": json.load(open(file_path))})
            print(f"Loaded {file_name}")

cities_doc = []

for city in cities:
    doc = {
        "name": city["name"],
        "streets": [street_to_coords(street) for street in city["data"]["features"]]
    }
    cities_doc.append(doc)

csvs = {}
for subdir, dirs, files in os.walk(dataset_dir):
    if subdir == dataset_dir or subdir.endswith('output'):
        continue
    print("found subdirectory: " + os.path.basename(subdir))
    csvs[os.path.basename(subdir)] = [os.path.join(subdir, file) for file in files if file.endswith('.csv')]
    print(f"Loaded {os.path.basename(subdir)}")

def iterate_csvs(year_file):
    all_event_docs = []
    for i in range(len(year_file)):
        parts = year_file[i].split('_')
        year = parts[-1][:4]
        event_docs = get_docs_from_csv(year_file[i])
        all_event_docs.extend(event_docs)
    return all_event_docs

async def load_data_mongo(mongo_client):
    print("Loading data to mongo...")

    # Insert streets geomtery
    mongo_client["ftd"]["polygons"].insert_many(cities_doc)

    # Create traffic timeseries collection
    mongo_client["ftd"].create_collection(
                "traffic_events",
                timeseries= {
                    "timeField": "timestamp",
                    "metaField": "metadata",
                    "granularity": "minutes"
                }
            )
    
    for property_name, year_file in csvs.items():
        event_docs = iterate_csvs(year_file)
        mongo_client["ftd"]["traffic_events"].insert_many(event_docs)
    
    mongo_client["ftd"]["traffic_events"].create_index("metadata.streetId")
        

async def load_data_file():
    print("Loading data to file...")
    with open("./datasets/output/polygons.json", "w") as f:
        json.dump(cities_doc, f)

    for property_name, year_file in csvs.items():
        street_docs, event_docs = iterate_csvs(year_file)
        with open(f"./datasets/output/{property_name}.json", "w") as f:
            json.dump(street_docs, f)
        with open(f"./datasets/output/{property_name}_traffic_events.json", "w") as f:
            json.dump(event_docs, f)
            

async def load_data_neo4j(driver):
    # Upload road network geometry
    for city in cities_doc:
        city_name = city["name"]
        query = f"""
            CALL apoc.mongo.find('mongodb://mongo:27017/ftd.polygons', {{name: '{city_name}'}}) YIELD value 
            WITH value.streets AS streets 
            UNWIND range(0, size(streets)-1) AS id
            WITH streets[id] AS current, id
            UNWIND range(0, size(current.coords)-2) AS coord_id 
            WITH current.coords[coord_id] AS current_c, current.coords[coord_id+1] AS next_c, id
            MERGE (c1:Coordinate {{latitude: current_c[1], longitude: current_c[0]}}) 
            MERGE (c2:Coordinate {{latitude: next_c[1], longitude: next_c[0]}}) 
            MERGE (c1)-[s:Segment]->(c2) 
            ON CREATE SET s.street_id = id
            ON MATCH SET s.street_id = id
        """
        with driver.session() as session:
            res = session.run(query)
            stats = res.consume().counters
            nodes_created = stats.nodes_created
            relationships_created = stats.relationships_created

            if nodes_created > 0 or relationships_created > 0:
                print("Neo4j: data added.")
            else:
                print("Neo4j: no data added.")
            print("Neo4j: query executed for " + city_name)
    
    # Upload road metadata
    query = f"""
        MATCH (c1)-[seg:Segment]->(c2)
        WITH COLLECT(DISTINCT seg.street_id) as streets
        UNWIND streets AS street
        CALL apoc.mongo.aggregate(
        'mongodb://mongo:27017/ftd.traffic_events',
        [
            {{
            `$match`: {{
                `metadata.streetId`: street
            }}
            }},
            {{
            `$group`: {{
                `_id`: null,
                `velocity_max`: {{ `$max`: "$velocity" }},
                `velocity_mean`: {{ `$avg`: "$velocity" }},
                `traffic_max`: {{ `$max`: "$traffic" }},
                `traffic_mean`: {{ `$avg`: "$traffic" }},
                `traffic_sum`: {{ `$sum`: "$traffic" }}
            }}
            }}
        ]
        ) YIELD value
        MERGE (s:Street {{id: street}})
        ON CREATE SET s.traffic_max = value.traffic_maX, s.traffic_mean = value.traffic_mean, s.traffic_sum = value.traffic_sum, s.velocity_mean = value.velocity_mean, s.velocity_max = value.velocity_max
        """
    with driver.session() as session:
            res = session.run(query)
            stats = res.consume().counters
            nodes_created = stats.nodes_created
            relationships_created = stats.relationships_created

            if nodes_created > 0 or relationships_created > 0:
                print("Neo4j: data added.")
            else:
                print("Neo4j: no data added.")
            print("Neo4j: query executed for metadata")
    


async def load_data(mongo_client, neo4j_driver):
    if mongo_client is not None:
        await load_data_mongo(mongo_client)
        await load_data_neo4j(neo4j_driver)
    elif neo4j_driver is not None:
        await load_data_neo4j(neo4j_driver)
    else:
        await load_data_file()
    print("Data loaded")

    
