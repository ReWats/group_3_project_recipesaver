import unittest
from backend.app import app
                                ######### POSSIBLE TEST CASES #########
        # due to timings we weren't able to include error handling within main.py and output.html,
        # these are the test cases we would have executed.


#class TestIngredientInput(unittest.TestCase):

######Test checks if the app correctly handles a valid input with a single ingredient.
    ##The input '1L milk' is a correctly formatted string with quantity and item.
    ##We can expect the app to return a status code of 200 and include 'milk' in the response data.
    ##This ensures that the scraping as well as the processing logic works for single inputs.

 #   def setUp(self):
 #       self.app = app.test_client()
 #       self.app.testing = True

#    def test_valid_single_ingredient(self):
        # Simulate input of a single ingredient
#        response = self.app.post('/output', data={'textarea': '1L milk'})

        # Check if the response status is 200 (successful)
#        self.assertEqual(response.status_code, 200)

        # Check if the response contains the ingredient 'milk'
#        self.assertIn(b'milk', response.data)

######This test checks that the app successfully handles multiple ingredients.
    ##Each ingredient has a quantity to match the app's requirements.
    ##Each of the individual ingredients is present in the returned HTML.
    ##This simulates a realistic user input to ensure the correct data handling and display.

#    def test_valid_multiple_ingredients(self):
        # Simulate input of multiple ingredients
#        response = self.app.post('/output', data={'textarea': '1l milk\r\n2 eggs\r\n2kg flour'})

        # Check if the response status is 200 (successful)
#        self.assertEqual(response.status_code, 200)

        # Check if the response contains all the ingredients
#        self.assertIn(b'milk', response.data)
#        self.assertIn(b'eggs', response.data)
#        self.assertIn(b'flour', response.data)

###### Tests for any empty inputs, this makes sure the app can gracefully handle if a user doesn't input anything
    ## An empty input is invalid, so we want to confirm the app doesn't crash
    ## and instead returns a response (e.g the error code with a friendly message).
    ## This just helps ensure the app is user-proof and can handle edge cases.

#    def test_empty_input(self):
#        response = self.app.post('/output', data={'textarea': ''})

#        self.assertEqual(response.status_code, 200)

#        self.assertIn(b'ERROR MESSAGE WOULD GO HERE', response.data)

##### Test checks how the app handles input that only contains a quantity.
    ##Since the app expects input in the format 'quantity + ingredient'.
    ##this ensures that the app doesnt break or crash when an incomplete input is provided.

#    def test_input_with_only_quantity(self):
#        response = self.app.post('/output', data={'textarea': '1'})
#        self.assertEqual(response.status_code, 200)
#        self.assertIn(b'ERROR MESSAGE WOULD GO HERE', response.data)

#####Tests for an ingredient with special characters.
    ##Simulates an unintentional error by the user.
    ##Should still return a successfull HTTP response.

#    def test_input_with_special_characters(self):
#        response = self.app.post('/output', data={'textarea': '1 €€€€€'})
#        self.assertEqual(response.status_code, 200)
#        self.assertIn(b'€€€€€', response.data)




#if __name__ == '__main__':
#    unittest.main()

