import os

from flask import Flask

app = Flask(__name__)


@app.route("/")
def hello_world():
    return "Test deploy - Trivy!!!!"
if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=os.environ.get("PORT", 80))
