#Rebecca's code for review
from flask import Flask, jsonify, request
from receipesaver_db import supermarkets, ingredients, prices, users, recipes, recipe_ingredients 


app = Flask(__name__)

#check endpoint reachable

@app.route("/", methods=["GET"])
def root():
    return jsonify("THIS IS ROOT")

#return ingredient name

@app.route('/ingredients/<name>', methods=["GET"])
def get_name(name):
    prod_name = retrieve_product_name(name)
    return jsonify(prod_name)

endpoint = "http://127.0.0.1:5001"



#return ingredient price

@app.route('/prices/<ingredient_id>, supermarket_id, price_per_unit', methods=['GET'])
def get_price():
    supermarket_price = request.get_json()
    price(
        ingredient_id=prices['ingredient_id'],
        supermarket_id=prices['supermarket_id'],
        price=prices['price_per_unit'],
    )

    return supermarket_price


if __name__ == '__main__':
    app.run(debug=True, port=5001)