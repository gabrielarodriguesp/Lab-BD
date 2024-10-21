from pymongo import MongoClient
from faker import Faker
import random

def seed_database():
    # Connection URI
    uri = "mongodb://root:root@localhost:27017/"

    # Create a MongoClient
    client = MongoClient(uri)

    # Access the 'cities' database
    db = client.cities

    # # Example data to insert
    # cities_data = [
    #     {"name": "New York", "country": "USA", "population": 8419000},
    #     {"name": "Los Angeles", "country": "USA", "population": 3980000},
    #     {"name": "Chicago", "country": "USA", "population": 2716000},
    #     {"name": "Houston", "country": "USA", "population": 2328000},
    #     {"name": "Phoenix", "country": "USA", "population": 1690000},
    #     {"name": "London", "country": "UK", "population": 8982000},
    #     {"name": "Berlin", "country": "Germany", "population": 3769000},
    #     {"name": "Tokyo", "country": "Japan", "population": 13960000},
    #     {"name": "Paris", "country": "France", "population": 2148000},
    #     {"name": "Sydney", "country": "Australia", "population": 5312000}
    # ]
    fake = Faker()

    # Generate example data to insert
    cities_data = []
    for _ in range(300):
        city = {
            "name": fake.city(),
            "country": fake.country(),
            "population": random.randint(100000, 20000000)  # Random population between 100k and 20M
        }
        cities_data.append(city)

    # Insert data into the 'cities' collection
    db.cities.insert_many(cities_data)

    print("Database seeded successfully!")

if __name__ == "__main__":
    seed_database()