#Rebecca's code for review

#import relevant items to ensure code runs correctly

from datetime import date
import mysql.connector
from config import USER, PASSWORD, HOST

#raise an error if not able to connect to the database
class DbConnectionError(Exception):
    pass

#connect to the database using mMySQL credential which have been stored in the config.py file
def _connect_to_db(db_name):
    connection = mysql.connector.connect(
        host=HOST,
        user=USER,
        password=PASSWORD,
        auth_plugin='mysql_native_password',
        database=db_name
    )
    return connection