import requests
import unittest

PORT = 5001


class TestCaseScrapeAPIEndpoints(unittest.TestCase):
    def setUp(self):
        # Perform HTTP Request before each test case
        self.url_main = f"http://127.0.0.1:{5001}/"
        self.url_cm = f"http://127.0.0.1:{5001}/config-management"
        self.url_co = f"http://127.0.0.1:{5001}/containers"
        self.url_health = f"http://127.0.0.1:{5001}/health"
        self.timer = 5

    def test_1_check_main_get_request(self):
        print(f"\nTest Case 1 [/]: Check status code and message\n")
        self.r = requests.get(self.url_main, timeout=self.timer)
        self.assertEqual(self.r.status_code, 200)
        self.assertIsNotNone(self.r.json())

    def test_2_check_cm_get_request(self):
        print(f"\nTest Case 2 [/config-management]: Check status code and message\n")
        self.r = requests.get(self.url_cm, timeout=self.timer)
        self.assertEqual(self.r.status_code, 200)
        self.assertIsNotNone(self.r.json())
    
    def test_3_check_co_get_request(self):
        print(f"\nTest Case 3 [/containers]: Check status code and message\n")
        self.r = requests.get(self.url_co, timeout=self.timer)
        self.assertEqual(self.r.status_code, 200)
        self.assertIsNotNone(self.r.json())

    def test_4_check_cm_get_request(self):
        print(f"\nTest Case 4 [/health]: Check status code and message\n")
        self.r = requests.get(self.url_health, timeout=self.timer)
        self.assertEqual(self.r.status_code, 200)
        self.assertIsNotNone(self.r.json())


if __name__ == '__main__':
    unittest.main()