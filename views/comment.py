import sqlite3
import json

def get_post_comments(url):
    with sqlite3.connect("./db.sqlite3") as conn:
        conn.row_factory = sqlite3.Row
        cursor = conn.cursor()

    if url['query_params']:
        cursor.execute("""
            SELECT
                c.id AS comment_id,
                c.post_id AS comment_post_id,
                c.date AS comment_date,
                c.author_id AS comment_author_id,
                c.content AS comment_content,
                u.id AS user_id,
                u.first_name AS user_first_name,
                u.last_name AS user_last_name,
                u.username AS user_username
            FROM comments c
            JOIN users u ON u.id = c.author_id
            WHERE c.post_id == ?
        """, (url['pk'],))

        query_results = cursor.fetchall()

        commentDetails = []
        for row in query_results:
            user = {
                "id": row['user_id'],
                "fist_name": row['user_first_name'],
                "last_name": row['user_last_name'],
                "username": row['user_username']  
            }
            comment = {
                "id": row['comment_id'],
                "post_id": row['comment_post_id'],
                "date": row['comment_date'],
                "author_id": row['comment_author_id'],
                "author": user,
                "content": row['comment_content']
            }
            commentDetails.append(comment)

    serialized_comment = json.dumps(commentDetails)
    return serialized_comment


def get_all_comments(url):
    with sqlite3.connect("./db.sqlite3") as conn:
        conn.row_factory = sqlite3.Row
        cursor = conn.cursor()

        cursor.execute("""
            SELECT
                id,
                post_id,
                date,
                author_id,
                content
            FROM comments
        """)

        query_results = cursor.fetchall()

        comments = []
        for row in query_results:
            comments.append(dict(row))
        
        serialized_comments = json.dumps(comments)
    return serialized_comments


def create_comment(comment_data):
    with sqlite3.connect("./db.sqlite3") as conn:
        cursor = conn.cursor()

        cursor.execute("""
            INSERT INTO comments (post_id, date, author_id, content)
            VALUES (?, ?, ?, ?)
        """, (comment_data['postId'], comment_data['date'], comment_data['authorId'], comment_data['content'])
        )

        rows_created = cursor.rowcount
    
    return True if rows_created > 0 else False

