import time
import redis
import psycopg2 as pg

from flask import Flask

app = Flask(__name__)
cache = redis.Redis(host='redis', port=6379)
conn = None
cursor = None

conn = pg.connect(dbname='docker', user='docker', password='docker', host='db')
cursor = conn.cursor()

def get_hit_count():
    retries = 5
    while True:
        try:
            return cache.incr('hits')
        except redis.exceptions.ConnectionError as exc:
            if retries == 0:
                raise exc
            retries -= 1
            time.sleep(0.5)


@app.route('/')
def hello():
    count = get_hit_count()
    # db_test = cursor.execute("""SELECT current_database();""")
    db_test = cursor.execute("""SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;""")
    items = cursor.fetchall()
    conn.commit()

    return 'Hello World! I have been seen {} times. {}\n '.format(count, str(items))