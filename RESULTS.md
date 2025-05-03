# Recipesaver App

# Overview

We have created an application that scrapes product princes from different supermarket websites using an API and compares those prices side by side. The data is stored in a MySQL database and is displayed via a user friendly frontend interface using html and css.

# Key Features

- Frontend UI with search functionality

- Scrapes the web for product prices from the following supermarkets:
    - Aldi
    - Morrisons
    - Sainsbury
    - Tesco
    - Waitrose

- Storage of data using MySQL.

- Reusable database utility functions.

- A modular backend that utilises Flask and Python 3.

- Price comparisons are displayed in a user friendly frontend utilising html and css.

# What the App Does

1. Scrapes real time prices for specific quantities of products, eg: 0.5kg of sugar, 6 eggs from 5 major UK supermarkets

2. Saves the prices and product details into a MySQL database.

3. Displays the compared results in the frontend using html.

# Sample of Comparison Results

[******WIP to be added*****]

# What is Working Well

- Scraping logic is successfully extracting real time prices from our desired supermarkets.

- The MySQL integration reliably stores and retrieves data.

- Flask server and beautifulsoup loads and displays comparisons in a user friendly format.

- Unit testing incorporated for each supermarket product scrape.

# Areas for improvement

- Expand number of supermarkets included in the application.

- Include scheduled scraping (eg: daily price updates). This would help to speed up the application.

# Next Steps

- Optimise scraping speed and robustness

- Adjust quantity search function to work with following formats: 500 grams / 200 millilitres