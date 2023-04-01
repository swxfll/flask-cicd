import datetime

from flask import Flask

app = Flask(__name__)


@app.route('/')
def hello_world():  # put application's code here
    return "<h1>" + str(datetime.datetime.now()) +  "<br>Version: V1.0.6</h1>"

if __name__ == '__main__':
    app.run()
