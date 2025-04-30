#Rebecca's code for review
import requests
import json

#function to get prices, supermarket and product id

def get_prices(ingredient_id, supermarket_id, price_per_unit):

    price = {
        "ingredient": ingredient_id,
        "supermarket": supermarket_id,
        "price": price_per_unit,
        }
    result = requests.put(
        'http://127.0.0.1:5001/price',
        headers={'content-type': 'application/json'},
        data=json.dumps(price)
        )

    return result.json()

#prints out the cheapest supermarkets into a table > not finished, I got stuck here

def display_prices(results):
    
    print("{cheapest supermarket} {supermarket 2} {supermarket 3} {supermarket 4} {most expensive supermarket}".format(
        'NAME', 'Tesco', 'Morrisons', 'Waitrose', 'Aldi', 'Sainsbury'))
    print('-')

    
    for item in results:
        print( .format(
            item['supermarket_id'], 
        ))
        
#run code and get input from user somehow linked to the frontend

def run():
    #ignore print statements > just a placeholder - need to link to frontend
    print('Welcome to RecipeSaver!') 
    ingredients = input('Somehow link to frontend/output/html')
    prices = get_prices(price_per_unit)
    print('These are the prices we have found at the following supermarkets:')
    #need to work out how to link to supermarket cards n the front end
    display_prices(supermarket-card aldi, supermarket-card morrisons, supermarket-card tesco, supermarket-card sainsbury, supermarket-card waitrose)

    #again ignore the print statement > just a place holder
    print('Thank you for using RecipeSaver!')


if __name__ == '__main__':
    run()