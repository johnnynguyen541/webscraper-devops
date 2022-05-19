from flask import Flask, jsonify
from flask_restful import Resource, Api
from get_tech_data import get_dataynze_top_tech

# Global Variables
APP_PORT = 5001
CM_URL = 'https://www.datanyze.com/market-share/configuration-management--313'
CO_URL = 'https://www.datanyze.com/market-share/containerization--321'
CM_NAME = "config-management"
CO_NAME = "containers"

# Flask Setup
app = Flask(__name__)
app.config['JSON_SORT_KEYS'] = False  # Field to disable jsonify AutoSort
api = Api(app)


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
                        'Name': 'Puppet',
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


api.add_resource(DatanyzeAll, '/')
api.add_resource(DatanyzeCM,  '/config-management')
api.add_resource(DatanyzeCO,  '/containers')
api.add_resource(Health,      '/health')

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=APP_PORT)
