import sqlite3
import json



def get_single_post(url):
    with sqlite3.connect("./db.sqlite3") as conn:
        conn.row_factory = sqlite3.Row
        cursor = conn.cursor()

        cursor.execute("""
            SELECT * FROM posts p
            WHERE p.id == ?
        """, (url['pk'],))

        query_results = cursor.fetchone()
        post_dictionary = dict(query_results)

        serialized_post = json.dumps(post_dictionary)

    return serialized_post