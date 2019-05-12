import csv
import sqlite3
import time

CSV_PATH = "./public/sentences.csv"
DB_PATH = "./public/sentences.sqlite3"


def getSentences():
    with open(CSV_PATH) as csvf:
        reader = csv.reader(csvf, delimiter="\t")
        for row in reader:
            yield row


def setupDB(conn: sqlite3.Connection):
    conn.execute("DROP TABLE IF EXISTS sentences")
    conn.execute(
        "CREATE TABLE IF NOT EXISTS sentences (id INTEGER PRIMARY KEY, lang TEXT, sentence TEXT);")


def writeRow(conn: sqlite3.Connection, id, lang, sentence):
    conn.execute("INSERT INTO sentences VALUES (?, ?, ?);",
                 (id, lang, sentence))


def createLangIndex(conn):
    conn.execute("CREATE INDEX")


def seed(conn):
    setupDB(conn)
    sentencesGen = getSentences()
    try:
        for (i, line) in enumerate(sentencesGen):
            if i % 10000 == 0:
                print(f"writing entry {i}")
            (id, lang, sentence) = line
            writeRow(conn, id, lang, sentence)
    finally:
        conn.commit()


if __name__ == "__main__":
    conn = sqlite3.connect(DB_PATH)
    seed(conn)


# example query `SELECT * FROM sentences WHERE instr(sentences.sentence, ' test ') > 0 AND lang='eng';`
