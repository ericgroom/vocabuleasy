from pymongo import MongoClient
from app.settings import DB_USER, DB_NAME, DB_PASS, DB_PATH


client = MongoClient('localhost', 27017)
db = client.vocabuleasy
