"""
Copyright (c) 2020 Andre Telfer
"""

import time
import redis
import psycopg2 as pg
import uuid
import functools
from flask import Flask, request, jsonify

app = Flask(__name__)
cache = redis.Redis(host='redis', port=6379)
conn = None
cursor = None

conn = pg.connect(dbname='docker', user='docker', password='docker', host='db')
cursor = conn.cursor()

'''
My custom authentication function ;) it's probably not great but it was frustrating

Authenication Decorator, takes the post data and checks if there is a valid session
'''
def validate_auth(func):
    @functools.wraps(func)
    def wrapper_validate_auth(*args, **kwargs):
        data = None
        if request.method == 'POST':
            data = request.get_json()
        elif request.method == 'GET':
            data = request.args
        
        if not data or 'session' not in data:
            app.logger.info("No user session.")
            return jsonify(error='not authenticated')
        elif not cache.exists(data['session']):
            app.logger.info("Invalid session.")
            return jsonify(error='invalid session')
            
        app.logger.info("Valid session.")
        return func(*args, **kwargs)

    return wrapper_validate_auth


@app.route("/login", methods=['POST']) 
def login():
    req_data = request.get_json()
    app.logger.info(f"Login for username: {req_data['username']}, password: {req_data['password']}" )

    # No password hashing or anything :(
    cursor.execute("""
        SELECT * FROM user_account
        WHERE username=%s AND password=%s;
    """, (req_data['username'], req_data['password']))
    user = cursor.fetchone()

    if user is None:
        app.logger.info("User not found.")
        return jsonify(auth=False)

    app.logger.info("User found.")

    # potential set expiry time here in the future or other?
    session = str(uuid.uuid1())
    cache.set(session, req_data['username']) 

    return jsonify(auth=True, session=session)
    

@app.route("/logout", methods=['POST']) 
@validate_auth
def logout():
    app.logger.info("Logging user out.")
    req_data = request.get_json()
    return jsonify(message="Logged out!")

@app.route("/books", methods=['GET'])
def get_books():
    cursor.execute("""
        SELECT * FROM book_details; 
    """)
    books = cursor.fetchall()
    columns = [desc[0] for desc in cursor.description]
    data = [dict(zip(columns, book)) for book in books]
    app.logger.info(data)
    return jsonify(books=data)

