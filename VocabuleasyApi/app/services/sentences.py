import sqlite3
from collections import namedtuple
from app.settings import DB_PATH

Sentence = namedtuple("Sentence", ["id", "lang", "sentence"])


def get_connection():
    return sqlite3.connect(DB_PATH)


def get_sentences(word):
    conn = get_connection()
    c = conn.execute(
        "SELECT * FROM sentences WHERE instr(sentences.sentence, ?) > 0 AND lang='eng' LIMIT 10;", (word,))
    sentences = c.fetchall()
    return [Sentence(*row) for row in sentences]
