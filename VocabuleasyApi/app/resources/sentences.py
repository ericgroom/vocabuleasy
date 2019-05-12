from flask_restful import Resource


class SentenceResource(Resource):
    def get(self):
        return "hello"
