from random import choices
from flask_restful import Resource, reqparse, abort
from app.services import get_sentences

parser = reqparse.RequestParser()
parser.add_argument(
    "lang", help="iso639-3 code for language you want to search for")
parser.add_argument("word", help="word to search for")


class SentenceResource(Resource):
    def get(self):
        args = parser.parse_args(strict=True)
        word = args["word"]
        lang = args["lang"]
        if not word or not lang:
            abort(400, message="Missing argument word or lang")
        sentences = get_sentences(lang, word)
        if not sentences:
            return []
        rsentences = choices(sentences, k=5)
        return [sentence.sentence for sentence in rsentences]
