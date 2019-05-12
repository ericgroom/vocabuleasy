from flask import Flask
from flask_restful import Api

from api.resources import SentenceResource

app = Flask(__name__)
api = Api(app)

api.add_resource(SentenceResource, "/")
