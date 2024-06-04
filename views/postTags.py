import sqlite3
import json




def get_post_tags(url):
    with sqlite3.connect("./db.sqlite3") as conn:
        conn.row_factory = sqlite3.Row
        db_cursor = conn.cursor()

        if url['query_params']:
            db_cursor.execute("""
                SELECT
                    p.id AS posttag_id,
                    p.post_id AS posttag_post_id,
                    p.tag_id AS posttag_tag_id,
                    t.id AS tag_id,
                    t.label AS tag_label
                FROM PostTags p
                JOIN Tags t ON t.id = p.tag_id
                WHERE p.post_id == ?
            """, (url['pk'],))
            query_results = db_cursor.fetchall()

            tags = []
            for row in query_results:
                tag = {
                    "id": row['tag_id'],
                    "label": row['tag_label']
                }
                posttag = {
                    "id": row['posttag_id'],
                    "post_id": row['posttag_post_id'],
                    "tag_id": row['posttag_tag_id'],
                    "tag": tag
                }
                tags.append(dict(posttag))

            serialized_posttag = json.dumps(tags)
            return serialized_posttag
        
        else:
            db_cursor.execute("""
                SELECT * FROM PostTags p
                WHERE p.post_id == ?
            """, (url['pk'],))

            query_results = db_cursor.fetchall()

            tags = []
            for row in query_results:
                tags.append(dict(row))

            serialized_posttag = json.dumps(tags)
            return serialized_posttag


def get_all_post_tags(url):    
    with sqlite3.connect("./db.sqlite3") as conn:
        conn.row_factory = sqlite3.Row
        db_cursor = conn.cursor()

        db_cursor.execute("""
        SELECT
            p.id,
            p.post_id,
            p.tag_id
        FROM PostTags p
        """)
        query_results = db_cursor.fetchall()

        postTags = []
        for row in query_results:
            postTags.append(dict(row))
        
        serialized_postTags = json.dumps(postTags)
    
    return serialized_postTags
  
  
def update_post_tags(post_id, body):
    with sqlite3.connect("./db.sqlite3") as conn:
        conn.row_factory = sqlite3.Row
        new_tags = body.get('updatedTags', [])
        db_cursor = conn.cursor()

        db_cursor.execute("""
            DELETE FROM PostTags WHERE post_id = ?
        """, (post_id,))

        db_cursor.executemany("""
            INSERT INTO PostTags (post_id, tag_id)
            VALUES (?,?)
        """, [(post_id, tag_id) for tag_id in new_tags])

        conn.commit()

        rows_affected = db_cursor.rowcount

    return True if rows_affected > 0 else False

  
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

