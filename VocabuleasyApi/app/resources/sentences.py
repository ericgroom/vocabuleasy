from random import choices
from flask import request
from flask_restful import Resource, abort
from app.services import get_sentences


class SentenceResource(Resource):
    def post(self):
        body = request.get_json()
        word, lang = body["word"], body["lang"]

        if not word or not lang:
            abort(400, message="Missing argument word or lang")

        sentences = [entry["sentence"] for entry in get_sentences(lang, word)]
        return {'sentences': sentences}
