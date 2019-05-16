import csv
import sqlite3
import time
import pymongo
from app.db import db

CSV_PATH = "./public/sentences.csv"


def getSentences():
    with open(CSV_PATH) as csvf:
        reader = csv.reader(csvf, delimiter="\t")
        for row in reader:
            d = {'id': row[0], 'lang': row[1], 'sentence': row[2]}
            yield d


def seed(table):
    sentencesGen = getSentences()
    cache = []
    for (i, data) in enumerate(sentencesGen):
        if i % 100000 == 0 and cache:
            table.insert_many(cache)
            cache.clear()
            print(f"writing chunk {i}")
        cache.append(data)
    if cache:
        table.insert_many(cache)


def createLangIndex(table):
    table.create_index(["sentence", pymongo.TEXT])


if __name__ == "__main__":
    print("Attempting to connect to db")
    collection = db.sentences
    seed(collection)
    createLangIndex(collection)
