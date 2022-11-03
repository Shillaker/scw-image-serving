from flask import Flask, send_file
from datetime import datetime
from os.path import exists
import json

app = Flask(__name__)

DUMMY_IMAGE = "/images/dummy.png"
MIME_TYPE = "image/png"


@app.route("/")
def root():
    now = datetime.now()
    req_time = now.strftime("%H:%M:%S")
    return json.dumps({"message": f"Hello at {req_time}"})


@app.route("/img/<filename>")
def img(filename):
    img_path = f"/images/{filename}"

    # Check if image exists
    if exists(img_path):
        return send_file(img_path, mimetype=MIME_TYPE)
    else:
        return send_file(DUMMY_IMAGE, mimetype=MIME_TYPE)


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port="8080")
