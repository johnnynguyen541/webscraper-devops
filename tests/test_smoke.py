import requests
import unittest

PORT = 5001


class TestCaseSmokeTest(unittest.TestCase):
    def setUp(self):
        # Perform HTTP Request before each test case
        self.url_health = f"http://127.0.0.1:{5001}/health"
        self.timer = 5

    def test_1_check_main_get_request(self):
        print(f"\nSmoke Test 1 [/health]: Check Endpoint")
        self.r = requests.get(self.url_health, timeout=self.timer)
        self.assertEqual(self.r.status_code, 200)
        self.assertIsNotNone(self.r.json())


if __name__ == '__main__':
    unittest.main()
