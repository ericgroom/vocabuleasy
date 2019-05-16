from os import path

dir = path.dirname(__file__)
DB_PATH = path.realpath(path.join(dir, "..", "public", "sentences.sqlite3"))
DB_NAME = "vocabuleasy"
DB_USER = "postgres"
DB_PASS = "postgres"
