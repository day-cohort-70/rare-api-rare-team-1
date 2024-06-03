import sqlite3
import json

def get_all_posts(url):
    with sqlite3.connect("./db.sqlite3") as conn:
        conn.row_factory = sqlite3.Row
        db_cursor = conn.cursor()

        if "query_params" in url and "_expand" in url["query_params"] and "users" and "categories" in url["query_params"]["_expand"]:
            db_cursor.execute("""
             SELECT
                p.id,
                p.user_id,
                p.category_id,
                p.title,
                p.publication_date,
                p.image_url,
                p.content,
                p.approved,
                u.id AS userId,
                u.username AS authorName,
                c.id AS categoryId,
                c.label AS categoryLabel
            FROM Posts p
            JOIN Users u ON p.user_id = u.id
            JOIN Categories c ON p.category_id = c.id
            ORDER BY p.publication_date DESC
            """)
        else:
            db_cursor.execute("""
             SELECT
                p.id,
                p.user_id,
                p.category_id,
                p.title,
                p.publication_date,
                p.image_url,
                p.content,
                p.approved
                ORDER BY p.publication_date DESC
            FROM Posts p
            """)

        query_results = db_cursor.fetchall()

        posts = []
        for row in query_results:
            post = {
                "id": row['id'],
                "user_id": row['user_id'],
                "category_id": row['category_id'],
                "title": row['title'],
                "publication_date": row['publication_date'],
                "image_url": row['image_url'],
                "content": row['content'],
                "approved": row['approved']
            }
            if "query_params" in url and "_expand" in url["query_params"] and "users" and "categories" in url["query_params"]["_expand"]:
                user = {
                    "id": row['userId'],
                    "username": row['authorName']
                }
                post["user"] = user
                category = {
                    "id": row['categoryId'],
                    "label": row['categoryLabel']
                }
                post["category"] = category

            posts.append(post)
        
        serialized_posts = json.dumps(posts)

    return serialized_posts
