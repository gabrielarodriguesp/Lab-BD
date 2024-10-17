import pymongo
import json

# MongoDB connection
client = pymongo.MongoClient("mongodb://root:root@localhost:27017/")
db = client["olympics"]

# Function to load json data and insert into MongoDB
def load_json_to_mongo(file_path, collection_name, id_field):
    with open(file_path, 'r', encoding='utf-8') as file:
        data = json.load(file)
        for item in data:
            if id_field in item:
                item["_id"] = item.pop(id_field)
        db[collection_name].insert_many(data)

# Load L01_PAIS.json
load_json_to_mongo('/home/cadavez/Documentos/LabBD/pratica7/Lab-BD/L01_PAIS.json', 'PAIS', 'ID')

# Load L02_OLIMPIADA.json
load_json_to_mongo('/home/cadavez/Documentos/LabBD/pratica7/Lab-BD/L02_OLIMPIADA.json', 'OLIMPIADA', 'ANO')

# Load L03_MODALIDADE.json
load_json_to_mongo('/home/cadavez/Documentos/LabBD/pratica7/Lab-BD/L03_MODALIDADE.json', 'MODALIDADE', 'ID')

# Load L04_LOCAL.json
load_json_to_mongo('/home/cadavez/Documentos/LabBD/pratica7/Lab-BD/L04_LOCAL.json', 'LOCAL', 'ID')

# Load L05_DISPUTA.json
load_json_to_mongo('/home/cadavez/Documentos/LabBD/pratica7/Lab-BD/L05_DISPUTA.json', 'DISPUTA', 'ID')