from flask import Flask, send_file, make_response
from datetime import datetime
from os.path import exists

app = Flask(__name__)

DUMMY_IMAGE = "/images/dummy.png"
MIME_TYPE = "image/png"


def add_cors_headers(response):
    response.headers.add("Access-Control-Allow-Origin", "*")
    response.headers.add("Access-Control-Allow-Headers", "*")
    response.headers.add("Access-Control-Allow-Methods", "*")

    return response


@app.route("/", methods=["GET", "POST", "OPTIONS"])
def root():
    now = datetime.now()
    req_time = now.strftime("%H:%M:%S")

    response = make_response(f"Hello at {req_time}")
    return add_cors_headers(response)


@app.route("/img/<filename>", methods=["GET", "POST", "OPTIONS"])
def img(filename):
    img_path = f"/images/{filename}"

    # Check if image exists
    img_path = img_path if exists(img_path) else DUMMY_IMAGE

    print(f"Serving image at {img_path}")

    response = send_file(img_path, mimetype=MIME_TYPE)
    return add_cors_headers(response)


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port="8080")
