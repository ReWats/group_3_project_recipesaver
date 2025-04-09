

# mock_group_project
A mock repository for the CFG Degree Specialisation Group Project.

Contributors:
Freddy Henderson,
Nikki Iyayi,
Malika Zaouri,
Leima Raz,
Rebecca Watson

# Introduction

Due to the increase in the cost of living in the UK in recent years, we have identified a need for households to be able to easily locate the cheapest grocery items quickly and accurately.

We have created a python application which uses the web scraping API Octoparse to compare grocery prices across major uk supermarkets and return the supermarket which has the lowest price of the product(s) searched for.

The application will have two main functions: 

1) Find the lowest cost per product for a users shopping list, this will result in a user potentially needing to visit multiple supermarkets to purchase each product, but they will receive the lowest possible price for each item in their shopping list.
2) Find the lowest cost, single supermarket for the entire shopping list saving time for the user but not necessarily giving the best savings.

Additional features are:

a) Allow users to store their favourite products and easily search the latest prices without having to input the product name each time
b) Calculate the price differences between the highest and lowest price of a product and return this information to the user eg: by shopping at X supermarket rather than Y supermarket you have saved £Z

# Logic and Rules

<u>User Input</u>
Load a saved recipe or manually enter items eg:
User can choose "Pancake Recipe" from their saved list or type: "milk. eggs, flour"

<u<Price Aggregation</u>
The Octoparse API scrpes price data in real time/
