import unittest
from backend.app import app


class TestIngredientInput(unittest.TestCase):

    def setUp(self):
        self.app = app.test_client()
        self.app.testing = True

    def test_valid_single_ingredient(self):
        # Simulate input of a single ingredient
        response = self.app.post('/output', data={'textarea': '1L milk'})

        # Check if the response status is 200 (successful)
        self.assertEqual(response.status_code, 200)

        # Check if the response contains the ingredient 'milk'
        self.assertIn(b'milk', response.data)

    def test_valid_multiple_ingredients(self):
        # Simulate input of multiple ingredients
        response = self.app.post('/output', data={'textarea': '1l milk\r\n2 eggs\r\n2kg flour'})

        # Check if the response status is 200 (successful)
        self.assertEqual(response.status_code, 200)

        # Check if the response contains all the ingredients
        self.assertIn(b'milk', response.data)
        self.assertIn(b'eggs', response.data)
        self.assertIn(b'flour', response.data)


if __name__ == '__main__':
    unittest.main()
