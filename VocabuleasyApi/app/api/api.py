from flask import Flask
from flask_restful import Api

from app.resources import SentenceResource
from app.db import db

app = Flask(__name__)
api = Api(app)

api.add_resource(SentenceResource, "/sentences")


@app.before_request
def before_request():
    print("opening connection")
    db.connect()


@app.after_request
def after_request(response):
    print("closing connection")
    db.close()
    return response
