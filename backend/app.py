from flask import Flask, render_template, request
from main import aldi_api_scrape

app = Flask(__name__)

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/output", methods=['GET', 'POST'])
def output():
    print(request.form.get("textarea"))
    # Get list
    # send list to function to put in db (quantity needed, item)
    return render_template("output.html")

if __name__ == "__main__":
    app.run(debug=True)