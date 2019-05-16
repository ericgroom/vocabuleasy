from peewee import *
from app.db import BaseModel


class Sentence(BaseModel):
    lang = CharField(index=True)
    sentence = TextField()
