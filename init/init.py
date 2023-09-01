import json
from random import random
import pandas as pd
import time

from pymongo import ASCENDING, DESCENDING, IndexModel
from utils import street_to_coords, get_docs_from_csv
import os

dataset_dir = "./datasets"

cities = []

for subdir, dirs, files in os.walk(dataset_dir):
    if subdir == dataset_dir:
        continue
    for file_name in files:
        file_path = os.path.join(subdir, file_name)
        if os.path.isfile(file_path) and file_name.endswith('.json'):
            #set the name as the folder name
            cities.append({"name": os.path.basename(subdir), "data": json.load(open(file_path))})
            print(f"Loaded {file_name} as {os.path.basename(subdir)}")

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

def iterate_csvs(year_file, dataset_name):
    all_event_docs = []
    for i in range(len(year_file)):
        parts = year_file[i].split('_')
        year = parts[-1][:4]
        event_docs = get_docs_from_csv(year_file[i], dataset_name)
        all_event_docs.extend(event_docs)
    return all_event_docs

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
        event_docs = iterate_csvs(year_file, property_name)
        mongo_client["ftd"]["traffic_events"].insert_many(event_docs)
    
    index1 = IndexModel([("metadata.streetId", ASCENDING),("metadata.dataset", ASCENDING)])
    mongo_client["ftd"]["traffic_events"].create_indexes([index1])
            

async def load_data_neo4j_traffic(driver, mongo_client, streets):
    if streets == None:
        street_query = """
            MATCH (s:Street)
            RETURN s.id AS id
        """
        with driver.session() as session:
            res = session.run(street_query)
            streets = [record['id'] for record in res]

    for street in streets:
        dataset = street.split('_')[0]
        street_id = street.split('_')[1]
        print("Neo4j: loading traffic data for " + street_id + "("+dataset+")")
        events = mongo_client['ftd']['traffic_events'].find({"metadata.dataset": dataset, "metadata.streetId": int(street_id) })
        for event in events:
            query = f"""
                MATCH (s:Street {{id: '{street}'}})
                WITH datetime({{epochmillis: apoc.date.parse("{event['timestamp']}", "ms", "yyyy-MM-dd HH:mm:ss")}}) AS date, s
                MERGE (t:Timestamp {{year: date.year, month: date.month, day: date.day, hour: date.hour, minute: date.minute}})
                MERGE (s)-[e:HAS_EVENT {{traffic: {event['traffic']}, velocity: {event['velocity']}}}]->(t)
            """
            with driver.session() as session:
                res = session.run(query)

async def load_data_neo4j(driver, mongo_client):
    # Upload road network geometry
    for city in cities_doc:
        city_name = city["name"]
        query = f"""
            CALL apoc.mongo.find('mongodb://mongo:27017/ftd.polygons', {{name: '{city_name}'}}) YIELD value 
            WITH value.streets AS streets 
            UNWIND range(0, size(streets)-1) AS id
            WITH streets[id] AS current, id
            UNWIND range(0, size(current.coords)-2) AS coord_id 
            WITH current.coords[coord_id] AS current_c, current.coords[coord_id+1] AS next_c, id, coord_id
            MERGE (s:Street {{id: '{city_name}_' + id}})
            MERGE (s)-[c:MADE_OF {{order: coord_id}}]->(seg:Segment {{start_coordinates: [current_c[1], current_c[0]], end_coordinates: [next_c[1], next_c[0]]}})
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
    
    streets = []

    street_query = """
        MATCH (s:Street)
        RETURN s.id AS id
    """
    with driver.session() as session:
        res = session.run(street_query)
        streets = [record['id'] for record in res]

    # Create Index on Street
    index_query = """
        CREATE INDEX street_id_index FOR (n:Street) ON (n.id)
    """
    with driver.session() as session:
        res = session.run(index_query)

    await load_data_neo4j_traffic(driver, mongo_client, streets)


async def load_data(mongo_client, neo4j_driver):
    if mongo_client is not None:
        await load_data_mongo(mongo_client)
        await load_data_neo4j(neo4j_driver, mongo_client)
    elif neo4j_driver is not None:
        await load_data_neo4j(neo4j_driver)
    else:
        await load_data_file()
    print("Data loaded")

    