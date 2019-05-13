from random import choices
from flask_restful import Resource, reqparse
from app.services import get_sentences

parser = reqparse.RequestParser()
parser.add_argument("word")


class SentenceResource(Resource):
    def get(self):
        args = parser.parse_args()
        word = args["word"]
        sentences = get_sentences(word)
        rsentences = choices(sentences, k=5)
        return [sentence.sentence for sentence in rsentences]
