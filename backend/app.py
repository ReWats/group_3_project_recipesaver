from flask import Flask, render_template, request
from backend.main import parameter_sorting
from backend.db_utils import get_all_recipes_db

app = Flask(__name__)

@app.route("/")
def index():
    context = get_all_recipes_db()
    print(context)
    return render_template("index.html", **context)

@app.route("/output", methods=['GET', 'POST'])
def output():
    input_values = repr(request.form.get("textarea"))
    context = parameter_sorting(input_values)
    return render_template("output.html", **context)

if __name__ == "__main__":
    app.run()
