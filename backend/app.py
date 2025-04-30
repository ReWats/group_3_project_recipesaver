from flask import Flask, render_template, request
from backend.main import parameter_sorting

app = Flask(__name__)

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/output", methods=['GET', 'POST'])
def output():
    input_values = repr(request.form.get("textarea"))
    context = parameter_sorting(input_values)
    return render_template("output.html", **context)

if __name__ == "__main__":
    app.run()
