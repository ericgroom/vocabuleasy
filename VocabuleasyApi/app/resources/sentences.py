from random import choice
from flask_restful import Resource, reqparse
from app.services import get_sentences

parser = reqparse.RequestParser()
parser.add_argument("word")


class SentenceResource(Resource):
    def get(self):
        args = parser.parse_args()
        word = args["word"]
        sentences = get_sentences(word)
        rsentence = choice(sentences).sentence
        return rsentence
