from flask import Flask
from flask_restful import Resource, Api
from os import path

import yaml

# Config Paths
APP_DIR = path.dirname(path.realpath(__file__))
SRC_DIR = path.dirname(APP_DIR)
PROJ_DIR = path.dirname(SRC_DIR)
MAIN_DIR = path.dirname(PROJ_DIR)
APP_CFG_PATH = path.join(MAIN_DIR, "config", "app.yml")
APP_CFG = {}

# Read config files
with open(APP_CFG_PATH, "r") as f:
    text = f.read()
    APP_CFG = yaml.load(text, Loader=yaml.FullLoader)

# Global Variables
API_IP = APP_CFG["scrape-api"]["ip"]
API_PORT = APP_CFG["scrape-api"]["port"]
API_HEALTH_URL = f"http://{API_IP}:{API_PORT}"

BOT_IP = APP_CFG["scrape-bot"]["ip"]
BOT_PORT = APP_CFG["scrape-bot"]["port"]
BOT_HEALTH_URL = f"http://{BOT_IP}:{BOT_PORT}"

# Flask Setup
app = Flask(__name__)
app.config['JSON_SORT_KEYS'] = False  # Field to disable jsonify AutoSort
api = Api(app)


class Health(Resource):
    """ Resource for Health.
        Parameters:
            GET: /health
        Returns:
            200, OK upon receipt
    """
    def get(self):
        return "OK"


api.add_resource(Health, '/', '/health')

if __name__ == '__main__':
    app.run(debug=True, host=API_IP, port=BOT_PORT)
