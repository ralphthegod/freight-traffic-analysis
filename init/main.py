from pymongo import MongoClient
from neo4j import GraphDatabase
from init import load_data
from dotenv import load_dotenv
import os
import asyncio

async def main():
    
    neo4j_url = "bolt://neo4j"
    mongodb_url = "mongodb://mongo:27017/"
    
    load_dotenv()

    neo4j_username = os.getenv("NEO4J_USERNAME")
    neo4j_password = os.getenv("NEO4J_PASSWORD")

    driver = GraphDatabase.driver(neo4j_url, auth=(neo4j_username, neo4j_password), encrypted=False)

    try:
        with driver.session() as session:
            result = session.run("RETURN 1 AS result")
            record = result.single()
            
            if record and record["result"] == 1:
                print("Neo4j: connection accepted.")
            else:
                print("Neo4j: connection refused.")
    except Exception as e:
        print(f"Neo4j error: {e}")

    client = MongoClient(mongodb_url)
    db = client['test']
    result = None

    if client is not None:
        try:
            result = client['ftd'].list_collection_names()
        except Exception as err:
            print('Error:', err)
            await load_data(None, None)
            return

        if not result:
            await load_data(client, driver)
            print('')
        else:
            print('Database is not empty')

    else:
        print("MongoDB: connection refused.")

if __name__ == '__main__':
    asyncio.run(main())
