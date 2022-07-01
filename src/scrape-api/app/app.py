from flask import Flask, jsonify
from flask_restful import Resource, Api
from get_tech_data import URL_TIMEOUT, get_dataynze_top_tech
from os import path

import requests
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

CM_URL = 'https://www.datanyze.com/market-share/configuration-management--313'
CO_URL = 'https://www.datanyze.com/market-share/containerization--321'
CM_NAME = "config-management"
CO_NAME = "containers"
HEADERS = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) '
                      'Gecko/20100101 Firefox/84.0'
}
URL_TIMEOUT = 5

# Flask Setup
app = Flask(__name__)
app.config['JSON_SORT_KEYS'] = False  # Field to disable jsonify AutoSort
api = Api(app)


class Config(Resource):
    """ Resource for config.
        Parameters:
            GET: /config
        Returns:
            200, config JSON upon receipt
    """
    def get(self):
        return APP_CFG


class DatanyzeAll(Resource):
    """ Resource for full JSON of All Datanyze Tools
        Parameters:
            GET: /
        Returns:
            200 upon receipt
            JSON in format List(Dictionary).  Example:

            [
                {
                    'name': 'config-management',
                    ...
                },
                {
                    'name': 'containers',
                    ...
                }
            ]
    """
    def get(self):
        return jsonify(
            [
                get_dataynze_top_tech(CM_URL, CM_NAME),
                get_dataynze_top_tech(CO_URL, CO_NAME)
            ]
        )


class DatanyzeCM(Resource):
    """ Resource for full JSON of Top CI tools.
        Parameters:
            GET: /config-management
        Returns:
            200 upon receipt
            JSON in format Dictionary.  Example:

            {
                'name': 'config-management',
                'url': 'https://...',
                'date': '2022:05:18__18:47:50',
                'data': {
                    1: {
                        'Name': 'Ansible',
                        'Company': 'Red Hat',
                        'Description': '...',
                        'Number of Companies Using': 9542,
                        '% Market Share': 25.35
                    },
                    2: {
                        'Name': 'Puppet',import requests

                        'Company': 'Puppet',
                        'Description': '...',
                        'Number of Companies Using': 7807,
                        '% Market Share': 20.74
                    },
                    ...
                }
            }
    """
    def get(self):
        return jsonify(get_dataynze_top_tech(CM_URL, CM_NAME))


class DatanyzeCO(Resource):
    """ Resource for full JSON of Top Containerization tools.
        Parameters:
            GET:/containers
        Returns:
            200 upon receipt
            JSON in format Dictionary.  Example:

            {
                "name": "containers",
                "url": "https://...",
                "date": "2022:05:19__01:01:30",
                "data": {
                    "1": {
                        "Name": "LXC",
                        "Company": "Canonical",
                        'Description': '...',
                        Number of Companies Using": 14340,
                        "% Market Share": 24.18
                    },
                    "2": {
                        "Name": "Docker",
                        "Company": "Docker",
                        'Description': '...',
                        "Number of Companies Using": 13857,
                        "% Market Share": 23.37
                    },
                    ...
                }
            }
    """
    def get(self):
        return jsonify(get_dataynze_top_tech(CO_URL, CO_NAME))


class Health(Resource):
    """ Resource for Health.
        Parameters:
            GET: /health
        Returns:
            200, OK upon receipt
    """
    def get(self):
        return "OK"


class Status(Resource):
    """ Resource for getting all API status.
        Parameters:
            GET: /status
        Returns:
            200, JSON on receipt
    """
    def get(self):
        scrape_status = {}

        try:
            r = requests.get(API_HEALTH_URL,
                             headers=HEADERS,
                             timeout=URL_TIMEOUT)
            scrape_status["scrape-api"] = r.status_code
        except Exception as e:
            print(f"Please check connection to {API_HEALTH_URL}")
            scrape_status["scrape-api"] = None

        try:
            r = requests.get(BOT_HEALTH_URL,
                             headers=HEADERS,
                             timeout=URL_TIMEOUT)
            scrape_status["scrape-bot"] = r.status_code
        except Exception as e:
            print(f"Please check connection to {BOT_HEALTH_URL}")
            scrape_status["scrape-bot"] = None

        return scrape_status


api.add_resource(Config,      '/config')
api.add_resource(DatanyzeAll, '/')
api.add_resource(DatanyzeCM,  '/config-management')
api.add_resource(DatanyzeCO,  '/containers')
api.add_resource(Health,      '/health')
api.add_resource(Status,      '/status')

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=API_PORT)
