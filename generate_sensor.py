import json
import random

# Function to generate random temperature data
def generate_sensor_data(num_entries):
    data = []
    for i in range(num_entries):
        entry = {
            "deviceId": f"sensor_{i:03d}",
            "timestamp": f"2024-10-30T{random.randint(0, 23):02d}:{random.randint(0, 59):02d}:{random.randint(0, 59):02d}",
            "temperature": round(random.uniform(-20.0, 50.0), 2),  # Random temperature between -20 to 50 degrees Celsius
            "humidity": round(random.uniform(0.0, 100.0), 2),     # Random humidity percentage
            "location": {
                "latitude": round(random.uniform(-90.0, 90.0), 6),
                "longitude": round(random.uniform(-180.0, 180.0), 6)
            }
        }
        data.append(entry)
    return data

# Generate a large JSON file with fake sensor data
if __name__ == "__main__":
    num_entries = 10000  # Change this to generate more entries
    sensor_data = generate_sensor_data(num_entries)
    
    # Write to a JSON file
    with open("sensor_data.json", "w") as f:
        json.dump(sensor_data, f, indent=4)

    print(f"Generated {num_entries} entries in sensor_data.json")
