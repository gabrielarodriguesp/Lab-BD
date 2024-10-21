import pymongo

# MongoDB connection
client = pymongo.MongoClient("mongodb://root:root@localhost:27017/")
db = client["olympics"]

# Function to create constraints
def create_constraints():
    # PAIS collection constraints
    db.command({
        "collMod": "PAIS",
        "validator": {
            "$jsonSchema": {
                "bsonType": "object",
                "required": ["NOME"],
                "properties": {
                    "NOME": {
                        "bsonType": "string",
                        "description": "must be a string and is required"
                    },
                    "CONTINENTE": {
                        "bsonType": "string",
                        "description": "must be a string"
                    },
                    "POPULACAO": {
                        "bsonType": "int",
                        "description": "must be an integer"
                    }
                }
            }
        }
    })

    # OLIMPIADA collection constraints
    db.command({
        "collMod": "OLIMPIADA",
        "validator": {
            "$jsonSchema": {
                "bsonType": "object",
                "required": ["PAIS", "CIDADE_SEDE", "DATA_INICIO", "DATA_ENCERRAMENTO"],
                "properties": {
                    "PAIS": {
                        "bsonType": "string",
                        "description": "must be a string and is required"
                    },
                    "CIDADE_SEDE": {
                        "bsonType": "string",
                        "description": "must be a string and is required"
                    },
                    "DATA_INICIO": {
                        "bsonType": "date",
                        "description": "must be a date and is required"
                    },
                    "DATA_ENCERRAMENTO": {
                        "bsonType": "date",
                        "description": "must be a date and is required"
                    }
                }
            }
        }
    })

    # MODALIDADE collection constraints
    db.command({
        "collMod": "MODALIDADE",
        "validator": {
            "$jsonSchema": {
                "bsonType": "object",
                "required": ["ESPORTE", "GENERO"],
                "properties": {
                    "ESPORTE": {
                        "bsonType": "string",
                        "description": "must be a string and is required"
                    },
                    "GENERO": {
                        "bsonType": "string",
                        "enum": ["M", "F"],
                        "description": "must be 'M' or 'F' and is required"
                    }
                }
            }
        }
    })

    # LOCAL collection constraints
    db.command({
        "collMod": "LOCAL",
        "validator": {
            "$jsonSchema": {
                "bsonType": "object",
                "required": ["NOME", "CAPACIDADE"],
                "properties": {
                    "NOME": {
                        "bsonType": "string",
                        "description": "must be a string and is required"
                    },
                    "TIPO": {
                        "bsonType": "string",
                        "enum": ["ESTADIO", "GINASIO", "PISCINA"],
                        "description": "must be 'ESTADIO', 'GINASIO', or 'PISCINA'"
                    },
                    "CAPACIDADE": {
                        "bsonType": "int",
                        "minimum": 5000,
                        "description": "must be an integer greater than 5000 and is required"
                    }
                }
            }
        }
    })

    # DISPUTA collection constraints
    db.command({
        "collMod": "DISPUTA",
        "validator": {
            "$jsonSchema": {
                "bsonType": "object",
                "required": ["PAIS1", "PAIS2", "VENCEDOR", "MODALIDADE", "OLIMPIADA", "DATA_HORA", "LOCAL"],
                "properties": {
                    "PAIS1": {
                        "bsonType": "string",
                        "description": "must be a string and is required"
                    },
                    "PAIS2": {
                        "bsonType": "string",
                        "description": "must be a string and is required"
                    },
                    "VENCEDOR": {
                        "bsonType": "string",
                        "description": "must be a string and is required"
                    },
                    "MODALIDADE": {
                        "bsonType": "int",
                        "description": "must be an integer and is required"
                    },
                    "OLIMPIADA": {
                        "bsonType": "int",
                        "description": "must be an integer and is required"
                    },
                    "DATA_HORA": {
                        "bsonType": "date",
                        "description": "must be a date and is required"
                    },
                    "LOCAL": {
                        "bsonType": "int",
                        "description": "must be an integer and is required"
                    }
                }
            }
        }
    })

# Create constraints
create_constraints()
