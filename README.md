

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
-Installed packages: requests, re, beautifulsoup4, flask, mysql-connector-python, re
-MySQL workbench

# Introduction

Due to the increase in the cost of living in the UK in recent years, we have identified a need for households to be able to easily locate the cheapest grocery items quickly and accurately.

We have created a python application which uses ScraperAPI to search online websites to compare grocery prices across major uk supermarkets and return the supermarket which has the lowest price of the product(s) searched for.

The application will have two main functions: 

1) Find the lowest cost per product for a users shopping list, this will result in a user potentially needing to visit multiple supermarkets to purchase each product, but they will receive the lowest possible price for each item in their shopping list.
2) Find the lowest cost, single supermarket for the entire shopping list saving time for the user but not necessarily giving the best savings.

Additional features are:

1) Enter your required ingredients and their quantities manually or select from a database of commonly used  ingredients (eg: 1 litre milk, 6 eggs, 0.5 kilogrammes flour.)

# Logic and Rules

User Input:
User manually enters items eg:
User can enter a list of ingredients: "orange, apple" or they can select from a database of popular items, such as a pancake recipe: "milk. eggs, flour"

Price Aggregation:
ScraperAPI scrapes price data in real time from 3 UK supermarkets: Tesco, Morrisons and Aldi

Calculating cost:
-Single-Store total: Calculates the total cost if all items are bought from one store.
-Multi-Store optimisation: Recommends splitting the list across stores for maximum savings.

Example:
-Single-store: Tesco total = £5.00.
-Multi-store: Buy milk at Aldi (£1.10) + eggs at Tesco (£2.00) = Total £3.10.

Assumptions:
-Cost is more important to users than proximity.
-Websites for supermarkets permit scraping.
-Items are available in at least one supermarket.

Data Flow Example:
User input (e.g. ‘Milk, eggs’)  → Backend search URLs → Scraper fetches prices → System calculates total cost → User sees the most affordable shop to find chosen ingredients.

# Instructions For User

-Please be advised the program is slow and will take sometime to run, this is something we would work on in our future improvements.

-You will need to create an account for ScraperAPI to obtain your unique API key which you will enter in the config.py file in order to run the code

-In your source code editor; install Python 3
-Create a virtual environment (venv)
-Install: requests, beautifulsoup4, flask, mysql-connector-python or run the requirements.txt file (pip install -r requirements.txt)

-Set up MySQL Database
-Start MySQL server
-Log in to MySQL: (mysql -u root -p)
-Enter your password then run: 

    sql

    CREATE DATABASE RecipeSaver;
    USE product_prices;
    SOURCE /path/to/Tables.sql

-Update the config.py file with your credentials so that the API can connect to your database, eg:

    HOST = "enter your host eg: localhost"
    USER = "enter your user eg: root"
    PASSWORD = "enter your MySQL password"
    APIKEY = "<api-key>"    


-Run the app.py file which contains the Flask routes and then; in the browser, type the url: http://127.0.0.1:5000 Go to the Templates folder and output.html to see the returned results of your search

-The db_utils.py file does not need to be run, this is a helper file that contains functions which are used by other files such as: main.py and app.py

# Constraints

Quantities:
When searching for quantities of the product required, insert in the following format:
    0.5 litre / 0.2 kilogramme 
    rather than: 
    500 grams / 200 millilitres 
Due to time constraints, we have not yet been able to resolve this however, it is a future fix that we would implement

Error Handling:
Due to time constraints, we have been unable to complete testing for error handling so user should ensure there are not typos in the ingredients being input to prevent issues with the code running.

# Activity Log

Please follow the link below to view the Activity Log in Google Sheets for this project:

[Activity Log](https://docs.google.com/spreadsheets/d/1k2Zm3fWgJ4qsiLSlswLE0CGPQdNmfZfOuqC7wljym80/edit?gid=0#gid=0)

# Trello Board

Please follow the link below to view the teams Trello board

[Trello Board](https://trello.com/b/9LdDxLCt/group-3-cfg)

