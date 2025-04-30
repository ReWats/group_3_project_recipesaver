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



def aldi_api_scrape(ingredient):
    payload = {'api_key': '68f66e079cf6b42e57365a68fd239b6f', 'url': f'https://www.aldi.co.uk/results?q={ingredient}'}
    r = requests.get('https://api.scraperapi.com/', params=payload)

    soup = BeautifulSoup(r.text, 'html.parser')
    print(soup.find(class_="product-tile"))

    aldi_item = soup.find(class_="product-tile__name")

    aldi_quant = str(soup.find(class_="product-tile__unit-of-measurement"))
    aldi_quant = aldi_quant[93:]
    aldi_quantity = int(re.search("[0-9]+", aldi_quant).group(0))

    # Price is price per item!
    aldi_pr = str(soup.find(class_="base-price__regular"))
    aldi_pr = aldi_pr[40:]
    aldi_price = float(re.search("[0-9]+\.[0-9]+", aldi_pr).group(0)) / aldi_quantity

    print(aldi_item)
    print(aldi_quantity)
    print(aldi_price)



aldi_api_scrape("orange")

