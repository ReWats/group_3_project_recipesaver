import re
import requests
from bs4 import BeautifulSoup
from config import APIKEY

def aldi_api_scrape(ingredient_string):
    # Grabs quantity from string (units / g / ml)
    match = re.search("[0-9]+", ingredient_string)
    if match:
        quantity = int(match.group(0))
    else:
        quantity = 1  # Default value if no quantity is found

    # grabs ingredient name. Done using split and join in case of two word names, e.g. "lemon juice"
    ingredient_temp = ingredient_string.split()[1:]
    ingredient = " ".join(ingredient_temp)

    # Builds URL and does API request
    payload = {'api_key': APIKEY, 'url': f'https://www.aldi.co.uk/results?q={ingredient}'}
    r = requests.get('https://api.scraperapi.com/', params=payload)

    # parses the API response into text
    soup = BeautifulSoup(r.text, 'html.parser')

    # We use this to work out the price per unit, as we need to know how much each item holds (e.g. 5 pack of oranges)
    aldi_quant = str(soup.find(class_="product-tile__unit-of-measurement"))
    aldi_quant = aldi_quant[93:]

    match_quantity = re.search("[1-9]+", aldi_quant)
    if match_quantity:
        aldi_quantity = int(match_quantity.group(0))
    else:
        aldi_quantity = 1  # Default value if no quantity found

    # Extracting the price
    aldi_pr = str(soup.find(class_="base-price__regular"))
    aldi_pr = aldi_pr[40:]
    # Note in the below line we divide by quantity so we get unit cost
    match_price = re.search("[0-9]+\.[0-9]+", aldi_pr)
    if match_price:
        aldi_price = float(match_price.group(0)) / aldi_quantity
    else:
        aldi_price = 0  # Default value if no price is found

    # Putting all the data we need to calculate costs into a dictionary
    ing_dict = {
        "ingredient_name": ingredient,
        "ingredient_quantity": quantity,
        "price_per_unit": aldi_price
    }

    return ing_dict

def morrisons_api_scrape(ingredient_string):
    # Grabs quantity from string (units / g / ml)
    quantity = int(re.search("[0-9]+", ingredient_string).group(0))
    # grabs ingredient name. Done using split and join in case of two word names, e.g. "lemon juice"
    ingredient_temp = ingredient_string.split()[1:]
    ingredient = " ".join(ingredient_temp)

    # Builds URL and does API request
    payload = {'api_key': APIKEY, 'url': f'https://groceries.morrisons.com/search?q={ingredient}'}
    r = requests.get('https://api.scraperapi.com/', params=payload)

    # Essentially parses the api response into text we can look through!
    soup = BeautifulSoup(r.text, 'html.parser')

    morr_pr = str(soup.find('span', attrs={'data-test': 'fop-price-per-unit'}))
    morr_pr = morr_pr[100:]
    morr_price = float(re.search("[0-9]+\.[0-9]+", morr_pr).group(0))

    # Putting all the data we need to calculate costs into a dictionary
    ing_dict = {
        "ingredient_name": ingredient,
        "ingredient_quantity": quantity,
        "price_per_unit": morr_price
    }

    return ing_dict

def tesco_api_scrape(ingredient_string):
    # Grabs quantity from string (units / g / ml)
    quantity = int(re.search("[0-9]+", ingredient_string).group(0))
    # grabs ingredient name. Done using split and join in case of two word names, e.g. "lemon juice"
    ingredient_temp = ingredient_string.split()[1:]
    ingredient = " ".join(ingredient_temp)

    # Builds URL and does API request
    payload = {'api_key': APIKEY,
               'url': f'https://www.tesco.com/groceries/en-GB/search?query={ingredient}'}
    r = requests.get('https://api.scraperapi.com/', params=payload)

    # Essentially parses the api response into text we can look through!
    soup = BeautifulSoup(r.text, 'html.parser')

    pr = str(soup.find(class_="ddsweb-price__subtext"))
    pr = pr[117:]
    price = float(re.search("[0-9]+\.[0-9]+", pr).group(0))

    # Putting all the data we need to calculate costs into a dictionary
    ing_dict = {
        "ingredient_name": ingredient,
        "ingredient_quantity": quantity,
        "price_per_unit": price
    }

    return ing_dict


def parameter_sorting(ingredients_string):
    # splits ingredients e.g. "1 orange\r\n500g flour\r\n20ml lemon juice" -> ["1 orange", "500g flour", "20ml lemon juice"]
    ingredients_list = ingredients_string.split(r"\r\n")

    # Aldi
    # Using map function as it iterates over every item in the parameters list easily!
    aldi_map = map(aldi_api_scrape, ingredients_list) # Passes each element in the lst to the aldi_api_scrape function
    aldi_ingredients_list = list(aldi_map)

    # Calculating total cost of aldi shop
    total_aldi_price = 0
    for i in aldi_ingredients_list:
        total_aldi_price = total_aldi_price + (i["price_per_unit"] * i["ingredient_quantity"])

    # Ensuring it has 2 decimal places
    total_aldi_price = float("{:.2f}".format(total_aldi_price))

    # Morrisons
    morr_map = map(morrisons_api_scrape, ingredients_list)
    morr_ingredients_list = list(morr_map)

    total_morr_price = 0
    for i in morr_ingredients_list:
        total_morr_price = total_morr_price + (i["price_per_unit"] * i["ingredient_quantity"])

    total_morr_price = float("{:.2f}".format(total_morr_price))

    # TESCO
    tesco_map = map(tesco_api_scrape, ingredients_list)
    tesco_ingredients_list = list(tesco_map)

    total_tesco_price = 0
    for i in tesco_ingredients_list:
        total_tesco_price = total_tesco_price + (i["price_per_unit"] * i["ingredient_quantity"])

    total_tesco_price = float("{:.2f}".format(total_tesco_price))

    # new dictionary to track the cheapest supermarket for each ingredient
    cheapest_supermarket_per_ingredient = {}
    # new dictionary to track savings when buying from multiple supermarkets
    mixed_basket_savings = 0

    # cheapest supermarket for each ingredient
    for index, ingredient in enumerate(aldi_ingredients_list):
        ingredient_name = ingredient["ingredient_name"]
        ingredient_quantity = ingredient["ingredient_quantity"]

        # get prices from each supermarket for a specific ingredient e.g. sugar
        aldi_price = aldi_ingredients_list[index]["price_per_unit"] * ingredient_quantity
        morr_price = morr_ingredients_list[index]["price_per_unit"] * ingredient_quantity
        tesco_price = tesco_ingredients_list[index]["price_per_unit"] * ingredient_quantity

        # finding out what the cheapest supermarket for a specific ingredient
        prices = {
            "Aldi": aldi_price,
            "Morrisons": morr_price,
            "Tesco": tesco_price
        }

        # get the cheapest supermarket and the price
        cheapest_supermarket = min(prices, key=prices.get)
        cheapest_price = prices[cheapest_supermarket]

        # add to our existing dictionary
        cheapest_supermarket_per_ingredient[ingredient_name] = cheapest_supermarket

        # calculate potential savings
        highest_price = max(prices.values())
        ingredient_savings = highest_price - cheapest_price
        mixed_basket_savings += ingredient_savings

    # mixed basket savings to two decimal places
    mixed_basket_savings = float("{:.2f}".format(mixed_basket_savings))

    # find the cheapest overall supermarket
    supermarket_totals = {
        "Aldi": total_aldi_price,
        "Morrisons": total_morr_price,
        "Tesco": total_tesco_price
    }

    cheapest_supermarket = min(supermarket_totals, key=supermarket_totals.get)
    cheapest_total = supermarket_totals[cheapest_supermarket]

    # calculate savings compared to the most expensive supermarket
    most_expensive_supermarket = max(supermarket_totals, key=supermarket_totals.get)
    most_expensive_total = supermarket_totals[most_expensive_supermarket]
    single_store_savings = most_expensive_total - cheapest_total
    single_store_savings = float("{:.2f}".format(single_store_savings))

    # list the total prices for each supermarket with info for the cheapest ingredient and where to find it
    output_dict = {
        "aldi_price": total_aldi_price,
        "morrisons_price": total_morr_price,
        "tesco_price": total_tesco_price,
        "cheapest_store": cheapest_supermarket,
        "cheapest_store_total": cheapest_total,
        "single_store_savings": single_store_savings,
        "cheapest_per_ingredient": cheapest_supermarket_per_ingredient,
        "mixed_basket_savings": mixed_basket_savings
    }

    print(output_dict)
    return output_dict

print(aldi_api_scrape("1 orange"))