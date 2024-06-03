import sqlite3
import json

def addPostTag(data):
    with sqlite3.connect("./db.sqlite3") as conn:
        db_cursor = conn.cursor()

        db_cursor.execute(
            """
            INSERT INTO PostTags (post_id, tag_id)
            VALUES (?,?)
            """, (data['post_id'], data['tag_id'])
        )

        rows_created = db_cursor.rowcount
    
    return True if rows_created > 0 else False