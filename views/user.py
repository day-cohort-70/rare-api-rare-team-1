import sqlite3
import json
from datetime import datetime


def login_user(user):
    """Checks for the user in the database

    Args:
        user (dict): Contains the username and password of the user trying to login

    Returns:
        json string: If the user was found will return valid boolean of True and the user's id as the token
                     If the user was not found will return valid boolean False
    """
    with sqlite3.connect('./db.sqlite3') as conn:
        conn.row_factory = sqlite3.Row
        db_cursor = conn.cursor()

        db_cursor.execute("""
            select id, username
            from Users
            where email = ?
            and password = ?
        """, (user['email'], user['password']))

        user_from_db = db_cursor.fetchone()

        if user_from_db is not None:
            response = {
                'valid': True,
                'token': user_from_db['id']
            }
        else:
            response = {
                'valid': False
            }

        return json.dumps(response)


def create_user(user):
    """Adds a user to the database when they register

    Args:
        user (dictionary): The dictionary passed to the register post request

    Returns:
        json string: Contains the token of the newly created user
    """
    with sqlite3.connect('./db.sqlite3') as connection:
        connection = sqlite3.connect('db.sqlite3')
        connection.row_factory = sqlite3.Row
        db_cursor = connection.cursor()

        db_cursor.execute("""
        INSERT INTO Users 
        (
            first_name,
            last_name,
            email,
            bio,
            username,
            password,
            created_on,
            profile_image_url,
            active
        )
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        """, (
            user['first_name'],
            user['last_name'],
            user['email'],
            user['bio'],
            user['username'],
            user['password'],
            datetime.now(),
            "https://www.shutterstock.com/image-vector/user-profile-icon-vector-avatar-600nw-2247726673.jpg",
            1
        ))

        new_user_id = db_cursor.lastrowid
        
        connection.commit()

        return json.dumps({
            'token': new_user_id,
            'valid': True
        })
