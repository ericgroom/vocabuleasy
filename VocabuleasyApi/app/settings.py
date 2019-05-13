from os import path

dir = path.dirname(__file__)
DB_PATH = path.realpath(path.join(dir, "..", "public", "sentences.sqlite3"))
