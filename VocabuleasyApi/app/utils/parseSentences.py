import csv
import sqlite3
import time
from peewee import chunked
from app.db import db
from app.models import Sentence

CSV_PATH = "./public/sentences.csv"


def getSentences():
    with open(CSV_PATH) as csvf:
        reader = csv.reader(csvf, delimiter="\t")
        for row in reader:
            yield row


# def createLangIndex(conn):
#     conn.execute("CREATE INDEX lang_index ON sentences(lang);")
#     conn.commit()


def seed(conn):
    sentencesGen = getSentences()
    with conn.atomic():
        for (i, data) in enumerate(chunked(sentencesGen, 100)):
            if i % 10000 == 0:
                print(f"writing chunk {i}")
            Sentence.insert_many(
                data, fields=[Sentence.id, Sentence.lang, Sentence.sentence]).execute()


if __name__ == "__main__":
    print("Attempting to connect to db")
    db.connect()
    db.create_tables([Sentence])
    seed(db)
    # createLangIndex(conn)
    db.close()


# example query `SELECT * FROM sentences WHERE instr(sentences.sentence, ' test ') > 0 AND lang='eng';`
