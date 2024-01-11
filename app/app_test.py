import unittest

from app import app


class TestApp(unittest.TestCase):
    def setUp(self):
        self.client = app.test_client()

    def test_hello_world(self):
        response = self.client.get("/")
        self.assertEqual(response.status_code, 200)
<<<<<<< HEAD
        self.assertEqual(response.data, b"Hello, Terraform - 17.12.2023!")
=======
        self.assertEqual(response.data, b"Hello, Kubernetes - 11.01.2024!")
>>>>>>> 407aec1e857bb4c09b6ac910bf62517533d2fa63


if __name__ == "__main__":
    unittest.main()
