from flask import Flask, render_template, request

from backend.main import parameter_sorting
from main import aldi_api_scrape

app = Flask(__name__)

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/output", methods=['GET', 'POST'])
def output():
    input_values = repr(request.form.get("textarea"))
    # print(input_values)
    # Get list
    # send list to function to put in db (quantity needed, item)
    parameter_sorting(input_values)
    return render_template("output.html")

if __name__ == "__main__":
    app.run(debug=True)