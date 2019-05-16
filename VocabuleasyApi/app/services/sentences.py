from peewee import fn
from app.models import Sentence


def get_sentences(lang, word):

    sentences = Sentence.select().where(
        Sentence.lang == lang, Sentence.sentence.contains(word))
    # sentences = Sentence.select().count()
    # print([sentence.sentence for sentence in sentences])
    return sentences
