try: 
    from flask import app
    import unittest
except Exception as e:
    print(f"Some Modules are  Missing {e}")


class FlaskTest(unittest.TestCase):

	# Check if Response is 200
	def test_index(self):
		tester = app.test_client(self)
		response = tester.get("/fo")  # Or full route
		statuscode = response.status_code
		self.assertEqual(statuscode, 200)
	
	# Check the contents ie. returns application/json
	def test_index_content(self):
		tester = app.test_client(self)
		response = tester.get("/fo")  # Or full route
		self.assertEqual(response.content_type, "application/json")

	# Check for Data Returned
	def test_index_content(self):
		tester = app.test_client(self)
		response = tester.get("/fo")  # Or full route
		self.assertTrue(b'Message' in response.data)


# To run
if __name__ == '__main__':
    unittest.main()
