from os import path

import requests
import unittest
import yaml


# Config Paths
TEST_DIR = path.dirname(path.realpath(__file__))
MAIN_DIR = path.dirname(TEST_DIR)
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


class TestCaseScrapeAPIEndpoints(unittest.TestCase):
    def setUp(self):
        # Perform HTTP Request before each test case
        self.url_main = f"{API_HEALTH_URL}/"
        self.url_cfg = f"{API_HEALTH_URL}/config"
        self.url_cm = f"{API_HEALTH_URL}/config-management"
        self.url_co = f"{API_HEALTH_URL}/containers"
        self.url_health = f"{API_HEALTH_URL}/health"
        self.url_status = f"{API_HEALTH_URL}/status"
        self.timer = 5

    def test_api_1_check_main_get_request(self):
        print(f"\nCase API-1 [/]: Check status and message\n")
        self.r = requests.get(self.url_main, timeout=self.timer)
        self.assertEqual(self.r.status_code, 200)
        self.assertIsNotNone(self.r.json())

    def test_api_2_check_cfg_get_request(self):
        print(f"\nCase API-2 [/config]: Check status and message\n")
        self.r = requests.get(self.url_cfg, timeout=self.timer)
        self.assertEqual(self.r.status_code, 200)
        self.assertIsNotNone(self.r.json())

    def test_api_3_check_cm_get_request(self):
        print(f"\nCase API-3 [/config-management]: Check status and message\n")
        self.r = requests.get(self.url_cm, timeout=self.timer)
        self.assertEqual(self.r.status_code, 200)
        self.assertIsNotNone(self.r.json())

    def test_api_4_check_co_get_request(self):
        print(f"\nCase API-4 [/containers]: Check status and message\n")
        self.r = requests.get(self.url_co, timeout=self.timer)
        self.assertEqual(self.r.status_code, 200)
        self.assertIsNotNone(self.r.json())

    def test_api_5_check_health_get_request(self):
        print(f"\nCase API-5 [/health]: Check status and message\n")
        self.r = requests.get(self.url_health, timeout=self.timer)
        self.assertEqual(self.r.status_code, 200)
        self.assertIsNotNone(self.r.json())

    def test_api_6_check_status_get_request(self):
        print(f"\nCase API-6 [/status]: Check status and message\n")
        self.r = requests.get(self.url_status, timeout=self.timer)
        self.assertEqual(self.r.status_code, 200)
        self.assertIsNotNone(self.r.json())


class TestCaseScrapeBOTEndpoints(unittest.TestCase):
    def setUp(self):
        # Perform HTTP Request before each test case
        self.url_main = f"{BOT_HEALTH_URL}/"
        self.url_health = f"{BOT_HEALTH_URL}/health"
        self.timer = 5

    def test_bot_1_check_main_get_request(self):
        print(f"\nCase BOT-1 [/]: Check status and message\n")
        self.r = requests.get(self.url_main, timeout=self.timer)
        self.assertEqual(self.r.status_code, 200)
        self.assertIsNotNone(self.r.json())

    def test_bot_2_check_health_get_request(self):
        print(f"\nCase BOT-2 [/health]: Check status and message\n")
        self.r = requests.get(self.url_health, timeout=self.timer)
        self.assertEqual(self.r.status_code, 200)
        self.assertIsNotNone(self.r.json())


if __name__ == '__main__':
    unittest.main()
