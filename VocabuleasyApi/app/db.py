from peewee import *
from app.settings import DB_USER, DB_NAME, DB_PASS, DB_PATH


db = PostgresqlDatabase(DB_NAME, user=DB_USER, password=DB_PASS)
# db = SqliteDatabase(DB_PATH)


class BaseModel(Model):
    class Meta:
        database = db
