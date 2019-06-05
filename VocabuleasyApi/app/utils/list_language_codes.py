from app.db import db


def get_language_codes():
    col = db.sentences
    return (row["_id"] for row in col.aggregate([{"$group": {"_id": "$lang"}}, {"$sort": {"_id": 1}}]))

if __name__ == "__main__":
    for lang in get_language_codes():
        print(lang)

