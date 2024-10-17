import csv
import json

# Function to read data from a CSV file
def read_csv_file(file_path):
    # Open the file with correct encoding and specify delimiter as semicolon
    with open(file_path, 'r', encoding='utf-8') as file:
        reader = csv.DictReader(file, delimiter=';')
        return [row for row in reader]

# Function to convert data to JSON
def convert_to_json(csv_data):
    return json.dumps(csv_data, ensure_ascii=False, indent=4)  # ensure_ascii=False for correct character handling

# Main function
def main():
    for i in range(1, 6):
        csv_file_path = f't{i}.csv'
        json_file_path = f't{i}.json'
        
        csv_data = read_csv_file(csv_file_path)
        json_data = convert_to_json(csv_data)
        
        with open(json_file_path, 'w', encoding='utf-8') as json_file:
            json_file.write(json_data)

if __name__ == "__main__":
    main()
