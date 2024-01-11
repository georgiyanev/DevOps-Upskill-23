import os

from flask import Flask

app = Flask(__name__)


@app.route("/")
def hello_world():
<<<<<<< HEAD
    return "Hello, Terraform - 17.12.2023!"
=======
    return "Hello, Kubernetes - 11.01.2024!"
>>>>>>> 407aec1e857bb4c09b6ac910bf62517533d2fa63


if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=os.environ.get("PORT", 80))
