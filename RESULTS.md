# Recipesaver App

# Overview

We have created an application that scrapes product prices from different supermarket websites using an API and compares those prices side by side. The data is stored in a MySQL database and is displayed via a user friendly frontend interface using html and css.

# Key Features

- Frontend UI with search functionality

- Scrapes the web for product prices from the following supermarkets:
    - Aldi
    - Morrisons
    - Tesco

- Storage of data using MySQL.

- Reusable database utility functions.

- A modular backend that utilises Flask and Python 3.

- Price comparisons are displayed in a user friendly frontend utilising html and css.

# What the App Does

1. Scrapes real time prices for specific quantities of products, eg: 0.5kg of sugar, 6 eggs from 3 major UK supermarkets

2. Saves the prices and product details into a MySQL database.

3. Displays the compared results in the frontend using html.

# What is Working Well

- Scraping logic is successfully extracting real time prices from our desired supermarkets.

- The MySQL integration reliably stores and retrieves data.

- Flask server and beautifulsoup loads and displays comparisons in a user friendly format.

- Unit testing incorporated for each supermarket product scrape.

# Next Steps

- Optimise scraping speed and robustness

- Adjust quantity search function to work with following formats: 500 grams / 200 millilitres

- Implement testing for error handling

# Areas for improvement

- Expand number of supermarkets included in the application. In our initial project discussions, we wanted our comparisons to also include Sainsbury's and Waitrose so the user had a broader range of supermarkets to choose from with varying expectations of product costs. Our initial research showed that Sainsbury's for instance, which many shoppers believe to be a mid range supermarket was actually cheaper for some products compared to it's competitors. Unfortunately, due to time constraints, we were forced to scale this back to a 3 supermarket comparison. We opted for supermarkets whose websites were easier to navigate with the code we had created.

- Include scheduled scraping (eg: daily price updates). This would help to speed up the application. We have observed that because we are scraping each website in real time, it can take sometime for results to be returned to the user. a future recommendation would be that the application incorporated scheduled daily scraping to reduce processing time for the user.

# Conclusion

We have created an app which functions as we intended. It is effective in capturing a users input via a simple and easy to use UI incorporating html and css. It is able to comunicate with ScraperAPI to fetch real time price data from; Tesco, Morrisons and Aldi. It can store a recipe or list of commonly used ingredients in a database and retrieve this information to return accurate price comparisons of the selected ingredients to the user. 

Due to ime constraints, we were unable to implement automated testing and complete debugging. This is something we would look to add in future improvements.

We believe this app has met a need for users who are looking for help in reducing their grocery expenses quickly and easily. We have created an application which is scalable and would allow us to add additional supermarkets in the future to give users a wider selection to choose from.
