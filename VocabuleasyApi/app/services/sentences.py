from collections import namedtuple
from app.db import db

Sentence = namedtuple("Sentence", ["id", "lang", "sentence"])


def get_sentences(lang, word):
    match = {"$match": {
        "$and": [{"lang": lang}, {"$text": {"$search": word}}]}}
    sample = {"$sample": {"size": 15}}
    sentences = db.sentences.aggregate([match, sample])

    return sentences
