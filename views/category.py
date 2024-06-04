import sqlite3
import json
from datetime import datetime


def get_single_category(url):
    with sqlite3.connect("./db.sqlite3") as conn:
        conn.row_factory = sqlite3.Row
        db_cursor = conn.cursor()

        db_cursor.execute("""
            SELECT * FROM Categories c
            WHERE c.id == ?
        """, (url['pk'],))

        query_results = db_cursor.fetchone()
        category_dictionary = dict(query_results)
        serialized_category = json.dumps(category_dictionary)

    return serialized_category


def grabCategoryList():
    with sqlite3.connect("./db.sqlite3") as conn:
        conn.row_factory = sqlite3.Row
        db_cursor = conn.cursor()

        db_cursor.execute("""
        SELECT
            c.id,
            c.label
        FROM Categories c
        """)
        query_results = db_cursor.fetchall()

        categories = []
        for row in query_results:
            categories.append(dict(row))

        serialized_categories = json.dumps(categories)

    return serialized_categories


def addCategory(label):
    with sqlite3.connect("./db.sqlite3") as conn:
        db_cursor = conn.cursor()

        db_cursor.execute(
            """
            INSERT INTO Categories (label)
            VALUES (?)
            """,
            (label,)
        )

        conn.commit()

    return True

def update_category(pk, data):
    with sqlite3.connect("./db.sqlite3") as conn:
        conn.row_factory = sqlite3.Row
        db_cursor = conn.cursor()

        db_cursor.execute("""
            UPDATE Categories
            SET
                label = ?
            WHERE id = ?
        """, (data['label'], pk))

        conn.commit()

        rows_affected = db_cursor.rowcount

    return True if rows_affected > 0 else False