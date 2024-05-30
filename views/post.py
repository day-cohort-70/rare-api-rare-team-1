import sqlite3
import json



def get_single_post(url):
    with sqlite3.connect("./db.sqlite3") as conn:
        conn.row_factory = sqlite3.Row
        cursor = conn.cursor()

    if url['query_params']:
        cursor.execute("""
            SELECT
                p.id AS post_id,
                p.user_id AS post_user_id,
                p.category_id AS post_category_id,
                p.title AS post_title,
                p.publication_date AS post_publication_date,
                p.image_url AS post_image_url,
                p.content AS post_content,
                p.approved as post_approved,
                u.id AS user_id,
                u.first_name AS user_first_name,
                u.last_name AS user_last_name,
                u.username AS user_username
            FROM posts p
            JOIN users u ON u.id = p.user_id
            WHERE p.id == ?
        """, (url['pk'],))

        query_results = cursor.fetchall()

        postDetails = []
        for row in query_results:
            user = {
                "id": row['user_id'],
                "fist_name": row['user_first_name'],
                "last_name": row['user_last_name'],
                "username": row['user_username']
            }
            post = {
                "id": row['post_id'],
                "user_id": row['post_user_id'],
                "user": user,
                "category_id": row['post_category_id'],
                "title": row['post_title'],
                "publication_date": row['post_publication_date'],
                "image_url": row['post_image_url'],
                "content": row['post_content'],
                "approved": row['post_approved']
            }
            postDetails.append(post)
        serialized_post = json.dumps(postDetails[0])
        return serialized_post

    else:
        cursor.execute("""
            SELECT * FROM posts p
            WHERE p.id == ?
        """, (url['pk'],))

        query_results = cursor.fetchone()
        post_dictionary = dict(query_results)

        serialized_post = json.dumps(post_dictionary)

    return serialized_post