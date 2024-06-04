import sqlite3
import json
from datetime import datetime

def getTagList():
    with sqlite3.connect("./db.sqlite3") as conn:
        conn.row_factory = sqlite3.Row
        db_cursor = conn.cursor()

        db_cursor.execute("""
        SELECT
            t.id,
            t.label
        FROM Tags t
        """)
        query_results = db_cursor.fetchall()

        tags = []
        for row in query_results:
            tags.append(dict(row))

        serialized_categories = json.dumps(tags)

    return serialized_categories


# def get_post_tags(url):
#     with sqlite3.connect("./db.sqlite3") as conn:
#         conn.row_factory = sqlite3.Row
#         db_cursor = conn.cursor()

#         if url['query_params']:
#             db_cursor.execute("""
#                 SELECT
#                     p.id AS posttag_id,
#                     p.post_id AS posttag_post_id,
#                     p.tag_id AS posttag_tag_id,
#                     t.id AS tag_id,
#                     t.label AS tag_label
#                 FROM PostTags p
#                 JOIN Tags t ON t.id = p.tag_id
#                 WHERE p.post_id == ?
#             """, (url['pk'],))
#             query_results = db_cursor.fetchall()

#         tags = []
#         for row in query_results:
#             tag = {
#                 "id": row['tag_id'],
#                 "label": row['tag_label']
#             }
#             posttag = {
#                 "id": row['posttag_id'],
#                 "post_id": row['posttag_post_id'],
#                 "tag_id": row['posttag_tag_id'],
#                 "tag": tag
#             }
#             tags.append(dict(posttag))

#         serialized_posttag = json.dumps(tags)

#     return serialized_posttag


def addTag(label):
    with sqlite3.connect("./db.sqlite3") as conn:
        db_cursor = conn.cursor()

        db_cursor.execute(
            """
            INSERT INTO Tags (label)
            VALUES (?)
            """,
            (label,)
        )

        conn.commit()

    return True
