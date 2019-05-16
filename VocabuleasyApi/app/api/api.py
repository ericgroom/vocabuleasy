from flask import Flask
from flask_restful import Api

from app.resources import SentenceResource
from app.db import db

app = Flask(__name__)
api = Api(app)

api.add_resource(SentenceResource, "/sentences")
