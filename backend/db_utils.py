import mysql.connector
from config import USER, PASSWORD, HOST, DATABASE


class DbConnectionError(Exception):
    pass


def _connect_to_db():
    cnx = mysql.connector.connect(
        host=HOST,
        user=USER,
        password=PASSWORD,
        auth_plugin='mysql_native_password',
        database=DATABASE
    )
    print(HOST)
    return cnx


def get_all_recipes_db():
    db_connection = None
    try:
        db_connection = _connect_to_db()
        cur = db_connection.cursor()

        query = """SELECT recipe_id, recipe_name FROM recipes LIMIT 1"""

        # query = """SELECT * FROM recipe_items ORDER BY created_at ASC;"""
        cur.execute(query)
        result = cur.fetchall()

        recipe_id = result[0][0]
        recipe_name = result[0][1]

        query = f"""SELECT item_name FROM recipe_items WHERE recipe_id = {recipe_id};"""

        cur.execute(query)
        result = cur.fetchall()

        cur.close()

        final_result = nice_printed_version(result)
        db_dict = {"name": recipe_name, "ingredients": final_result}

        return db_dict

    except Exception:
        raise DbConnectionError("Failed to read data from DB")

    finally:
        if db_connection:
            db_connection.close()

if __name__ == "__main__":
    pass


def nice_printed_version(my_list):
    formatted_string = ""
    for i in my_list:
        formatted_string = formatted_string + i[0] + ", "
    return formatted_string

print(get_all_recipes_db())