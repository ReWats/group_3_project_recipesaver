import requests
import re
from bs4 import BeautifulSoup

urldict = {
    "Aldi": "https://www.aldi.co.uk/results?q=",
    "Sainsburys": "https://www.sainsburys.co.uk/gol-ui/SearchResults/",
    "Tesco": "https://www.tesco.com/groceries/en-GB/search?query=",
    "Morrisons": "https://groceries.morrisons.com/search?q=",
    "Waitrose": "https://www.waitrose.com/ecom/shop/search?&searchTerm="
}

def aldi_api_scrape(ingredient_string):
    # Grabs quantity from string (units / g / ml)
    quantity = int(re.search("[0-9]+", ingredient_string).group(0))
    # grabs ingredient name. Done using split and join in case of two word names, e.g. "lemon juice"
    ingredient_temp = ingredient_string.split()[1:]
    ingredient = " ".join(ingredient_temp)

    # Builds URL and does API request
    payload = {'api_key': '68f66e079cf6b42e57365a68fd239b6f', 'url': f'https://www.aldi.co.uk/results?q={ingredient}'}
    r = requests.get('https://api.scraperapi.com/', params=payload)

    # Essentially parses the api response into text we can look through!
    soup = BeautifulSoup(r.text, 'html.parser')

    # We use this to work out the price per unit, as we need to know how much each item holds (e.g. 5 pack of oranges)
    aldi_quant = str(soup.find(class_="product-tile__unit-of-measurement"))
    aldi_quant = aldi_quant[93:]
    aldi_quantity = int(re.search("[0-9]+", aldi_quant).group(0))

    # Extractign the price
    aldi_pr = str(soup.find(class_="base-price__regular"))
    aldi_pr = aldi_pr[40:]
    # Note in the below line we divide by quantity so we get unit cost
    aldi_price = float(re.search("[0-9]+\.[0-9]+", aldi_pr).group(0)) / aldi_quantity

    # Putting all the data we need to calculate costs into a dictionary
    ing_dict = {
        "ingredient_name": ingredient,
        "ingredient quantity": quantity,
        "price_per_unit": aldi_price
    }

    return ing_dict


def parameter_sorting(ingredients_string):
    # splits ingredients e.g. "1 orange\r\n500g flour\r\n20ml lemon juice" -> ["1 orange", "500g flour", "20ml lemon juice"]
    ingredients_list = ingredients_string.split(r"\r\n")
    print(ingredients_list)
    # Aldi array
    aldi_map = map(aldi_api_scrape, ingredients_list)
    aldi_ingredients_list = list(aldi_map)
    print(aldi_ingredients_list)

    return aldi_ingredients_list

# aldi_api_scrape("20ml lemon juice")

# '1 orange\r\n1 lemon\r\n500g flour\r\n20ml cumin'

# print(parameter_sorting("1 orange\r\n1 lemon\r\n500g flour\r\n20ml cumin"))
