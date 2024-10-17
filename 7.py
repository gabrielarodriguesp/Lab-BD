import pymongo
import json

# MongoDB connection
client = pymongo.MongoClient("mongodb://root:root@localhost:27017/")
db = client["olympics"]

def transform_disputa():
    # Fetch all disputes
    disputes = db.DISPUTA.find()

    transformed_disputes = []

    for dispute in disputes:
        # Fetch related documents with error handling
        pais1 = db.PAIS.find_one({"NOME": dispute.get("PAIS1")}) or {"error": f"PAIS1 {dispute.get('PAIS1')} not found"}
        pais2 = db.PAIS.find_one({"NOME": dispute.get("PAIS2")}) or {"error": f"PAIS2 {dispute.get('PAIS2')} not found"}
        vencedor = db.PAIS.find_one({"NOME": dispute.get("VENCEDOR")}) or {"error": f"VENCEDOR {dispute.get('VENCEDOR')} not found"}

        # Ensure MODALIDADE, OLIMPIADA, and LOCAL are queried as strings
        modalidade_id = str(dispute.get("MODALIDADE"))
        olimpiada_id = str(dispute.get("OLIMPIADA"))
        local_id = str(dispute.get("LOCAL"))

        modalidade_doc = db.MODALIDADE.find_one({"_id": modalidade_id})
        modalidade = {
            "_id": modalidade_doc["_id"],
            "ESPORTE": modalidade_doc["ESPORTE"],
            "GENERO": modalidade_doc["GENERO"]
        } if modalidade_doc else {"error": f"MODALIDADE {modalidade_id} not found"}

        olimpiada_doc = db.OLIMPIADA.find_one({"_id": olimpiada_id})
        olimpiada = {
            "_id": olimpiada_doc["_id"],
            "PAIS": olimpiada_doc["PAIS"],
            "CIDADE_SEDE": olimpiada_doc["CIDADE_SEDE"],
            "DATA_INICIO": olimpiada_doc["DATA_INICIO"],
            "DATA_ENCERRAMENTO": olimpiada_doc["DATA_ENCERRAMENTO"]
        } if olimpiada_doc else {"error": f"OLIMPIADA {olimpiada_id} not found"}

        local_doc = db.LOCAL.find_one({"_id": local_id})
        local = {
            "_id": local_doc["_id"],
            "NOME": local_doc["NOME"],
            "TIPO": local_doc["TIPO"],
            "CAPACIDADE": local_doc["CAPACIDADE"],
            "PAIS": local_doc["PAIS"]
        } if local_doc else {"error": f"LOCAL {local_id} not found"}

        # Create the transformed dispute document
        transformed_dispute = {
            "PAIS1": pais1,
            "PAIS2": pais2,
            "VENCEDOR": vencedor,
            "MODALIDADE": modalidade,
            "OLIMPIADA": olimpiada,
            "DATA_HORA": dispute["DATA_HORA"],
            "LOCAL": local
        }

        transformed_disputes.append(transformed_dispute)

    # Insert transformed disputes into a new collection
    db.TRANSFORMED_DISPUTA.insert_many(transformed_disputes)

# Transform disputes
transform_disputa()

# Function to export transformed disputes to a JSON file
# Function to export transformed disputes to a JSON file
def export_to_json():
    transformed_disputes = list(db.TRANSFORMED_DISPUTA.find())
    
    # Convert ObjectId to string
    for dispute in transformed_disputes:
        dispute["_id"] = str(dispute["_id"])
        if dispute["PAIS1"] and "_id" in dispute["PAIS1"]:
            dispute["PAIS1"]["_id"] = str(dispute["PAIS1"]["_id"])
        if dispute["PAIS2"] and "_id" in dispute["PAIS2"]:
            dispute["PAIS2"]["_id"] = str(dispute["PAIS2"]["_id"])
        if dispute["VENCEDOR"] and "_id" in dispute["VENCEDOR"]:
            dispute["VENCEDOR"]["_id"] = str(dispute["VENCEDOR"]["_id"])
        if dispute["MODALIDADE"] and "_id" in dispute["MODALIDADE"]:
            dispute["MODALIDADE"]["_id"] = str(dispute["MODALIDADE"]["_id"])
        if dispute["OLIMPIADA"] and "_id" in dispute["OLIMPIADA"]:
            dispute["OLIMPIADA"]["_id"] = str(dispute["OLIMPIADA"]["_id"])
        if dispute["LOCAL"] and "_id" in dispute["LOCAL"]:
            dispute["LOCAL"]["_id"] = str(dispute["LOCAL"]["_id"])

    # Use ensure_ascii=False for proper UTF-8 encoding
    with open('/home/cadavez/Documentos/LabBD/pratica7/Lab-BD/transformed_disputes.json', 'w', encoding='utf-8') as file:
        json.dump(transformed_disputes, file, indent=4, ensure_ascii=False)


# Export transformed disputes to JSON
export_to_json()