

# group_3_project_recipesaver
A repository for the CFG Degree Specialisation Group Project.

Contributors:
Freddy Henderson,
Nikki Iyayi,
Malika Zaouri,
Hila Raz,
Leima Raz,
Rebecca Watson

# Basic requirements to run the program

-Source code editor such as PyCharm or VS Code
-Python 3 installed 
-Virtual Environment (venv) created
-Installed packages: requests, beautifulsoup4, flask, mysql-connector-python, re
-MySQL workbench

# Introduction

Due to the increase in the cost of living in the UK in recent years, we have identified a need for households to be able to easily locate the cheapest grocery items quickly and accurately.

We have created a python application which uses ScraperAPI to search online websites to compare grocery prices across major uk supermarkets and return the supermarket which has the lowest price of the product(s) searched for.

The application will have two main functions: 

1) Find the lowest cost per product for a users shopping list, this will result in a user potentially needing to visit multiple supermarkets to purchase each product, but they will receive the lowest possible price for each item in their shopping list.
2) Find the lowest cost, single supermarket for the entire shopping list saving time for the user but not necessarily giving the best savings.

Additional features are:

1) Calculate the price differences between the highest and lowest price of a product and return this information to the user eg: by shopping at X supermarket rather than Y supermarket you have saved £Z

# Logic and Rules

<u>User Input</u>
User manually enters items eg:
User can choose "Pancake Recipe" from their saved list or type: "milk. eggs, flour"

<u>Price Aggregation</u>
ScraperAPI scarpes price data in real time

<u>Calculating cost<u>
-Single-Store total: Calculates the total cost if all items are bought from one store.
-Multi-Store optimisation: Recommends splitting the list across stores for maximum savings.

Example:
-Single-store: Tesco total = £5.00.
-Multi-store: Buy milk at Asda (£1.10) + eggs at Tesco (£2.00) = Total £3.10.

<u>Tracking Savings</u>
-Evaluates how much the user spends in comparison to the most costly option.
=Example: By selecting Asda and Tesco over Sainsbury's, I was able to save £1.90.

<u>Assumptions</u>
-Cost is more important to users than proximity.
-Websites for supermarkets permit scraping.
-Items are available in at least one store.

# Instructions For User

-In your source code editor; install Python 3
-Create a virtual environment (venv)
-Install: requests, beautifulsoup4, flask, mysql-connector-python or run the requirements.txt file (pip install -r requirements.txt)

-Set up MySQL Database
-Start MySQL server
-Log in to MySQL: (mysql -u root -p)
-Enter your password then run: 

    sql

    CREATE DATABASE product_pices;
    USE product_prices;
    SOURCE /path/to/tables.sql

-Update the config.py file with your credentials so that the API can connect to your database, eg:

    HOST = "enter your host eg: localhost"
    USER = "enter your user eg: root"
    PASSWORD = "enter your MySQL password"

-Run the main.py file in the terminal to get fetch and compare price data from the different supermarkets and insert data

-Run the app.py file which contains the Flask routes and then;
    Go to the Templates folder and output.html to see the returned results of your search

-The db_utils.py file does not need to be run, this is a helper file that contains functions which are used by other files such as: main.py and app.py

# Constraints

<u>Quantities</u>
When searching for quantities of the product required, insert in the following format:
    0.5 litre / 0.2 kilogramme 
    rather than: 
    500 grams / 200 millilitres 
Due to time constraints, we have not yet been able to resolve this however, it is a future fix that we would implement



