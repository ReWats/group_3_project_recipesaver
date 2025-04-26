CREATE DATABASE recipesaver_db;
USE recipesaver_db;

-- Table 1: Users (stores account details for users saving recipes)
CREATE TABLE users (
	user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL, -- For authentication
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Table 2: Supermarkets
CREATE TABLE supermarkets(
	supermarket_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL, -- "Tesco", "Asda"
    website_url VARCHAR(255) NOT NULL -- For scraping reference
);

-- Table 3: Ingredients (standardised product names to prevent mismatches like "banana" vs "bananas" )
CREATE TABLE ingredients (
	ingredient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL, -- "milk", "banana" (singular)
    unit ENUM('g', 'ml', 'each') NOT NULL,
    description TEXT -- Optional details (e.g., "1L whole milk")
);

-- Table 4: Recipes (user saved recipes e.g., "Pancake mix", linked to their account)
CREATE TABLE recipes(
	recipe_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,  -- "Pancake mix"
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Table 5: RecipeIngredients (links recipes to their ingredients/quantities)
CREATE TABLE recipe_ingredients (
	recipe_id INT NOT NULL,
    ingredient_id INT NOT NULL,
    quantity DECIMAL(10,2), -- Optional (e.g., 2 for "2 bananans")
    PRIMARY KEY (recipe_id, ingredient_id),
    FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id),
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(ingredient_id)
);

-- Table 6: Prices (real-time data from scraping)
CREATE TABLE prices(
	prices_id INT AUTO_INCREMENT PRIMARY KEY,
    ingredient_id INT NOT NULL,
    supermarket_id INT NOT NULL,
    price_per_unit DECIMAL(10,5) NOT NULL,
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(ingredient_id),
    FOREIGN KEY (supermarket_id) REFERENCES supermarkets(supermarket_id),
    UNIQUE KEY (ingredient_id, supermarket_id) -- One price per ingredient/supermarket
);

-- Table 7: Shopping Lists
CREATE TABLE shopping_lists(
	list_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    name VARCHAR(100) NOT NULL, -- e.g., "Weekly groceries"
    is_recurring BOOLEAN DEFAULT FALSE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Table 8: Shopping list items (links lists to ingredients)
CREATE TABLE shopping_list_items(
	list_id INT NOT NULL,
    ingredient_id INT NOT NULL,
    quantity DECIMAL(10,2),
    PRIMARY KEY (list_id, ingredient_id),
	FOREIGN KEY (list_id) REFERENCES shopping_lists(list_id),
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(ingredient_id)
);

USE recipesaver_db;

-- Insert some supermarkets
INSERT INTO supermarkets(name, website_url) VALUES
('Aldi', 'https://www.aldi.co.uk/'),
('Morrisons', 'https://www.lidl.co.uk/'),
('Waitrose', 'https://www.waitrose.com/'),
('Sainsburys', 'https://www.sainsburys.co.uk/'),
('Tesco', 'https://www.tesco.com/');

INSERT INTO ingredients(name, unit, description) VALUES
('Plain flour', 'g', 'Price per gram'),
('Large eggs', 'each', 'Price per egg'),
('Whole milk', 'ml', 'Price per millilitre'),
('Sunflower oil', 'ml', 'Price per millilitre'),
('Lemon', 'each', 'Price per lemon'),
('Caster sugar', 'g', 'Price per gram');

-- Plain Flour Prices (ingredient_id = 1)
INSERT INTO prices (ingredient_id, supermarket_id, price_per_unit) VALUES
(1, 1, 0.00052),-- Aldi
(1, 2, 0.00106),-- Morrisons
(1, 3, 0.00100),-- Waitrose
(1, 4, 0.00090),-- Sainsbury’s
(1, 5, 0.00050); -- Tesco

-- Large Eggs (ingredient_id = 2)
INSERT INTO prices (ingredient_id, supermarket_id, price_per_unit) VALUES
(2, 1, 0.2917),-- Aldi
(2, 2, 0.33),-- Morrisons
(2, 3, 0.39), -- Waitrose
(2, 4, 0.33),-- Sainsbury’s
(2, 5, 0.32);-- Tesco

-- Whole Milk (ingredient_id = 3)
INSERT INTO prices (ingredient_id, supermarket_id, price_per_unit) VALUES
(3, 1, 0.00068), -- Aldi (£0.68/L → £0.00068/ml)
(3, 2, 0.00068),-- Morrisons (£0.68/L → £0.00068/ml)
(3, 3, 0.00168),-- Waitrose (£1.68/L → £0.00168/ml)
(3, 4, 0.00150), -- Sainsbury’s (£1.50/L → £0.00150/ml)
(3, 5, 0.00150);-- Tesco (£1.50/L → £0.00150/ml)

-- Sunflower Oil (ingredient_id = 4)
INSERT INTO prices (ingredient_id, supermarket_id, price_per_unit) VALUES
(4, 1, 0.002),-- Aldi (£0.20/100ml → £0.002/ml)
(4, 2, 0.002), -- Morrisons (£0.20/100ml → £0.002/ml)
(4, 3, 0.0023), -- Waitrose (£0.23/100ml → £0.0023/ml)
(4, 4, 0.002), -- Sainsbury’s (£0.20/100ml → £0.002/ml)
(4, 5, 0.002); -- Tesco (£0.20/100ml → £0.002/ml)

-- Lemon (ingredient_id = 5)
INSERT INTO prices (ingredient_id, supermarket_id, price_per_unit) VALUES
(5, 1, 0.17),   -- Aldi (£0.17/lemon)
(5, 2, 0.30),   -- Morrisons (£0.30/lemon)
(5, 3, 0.35),   -- Waitrose (£0.35/lemon)
(5, 4, 0.30),   -- Sainsbury’s (£0.30/lemon)
(5, 5, 0.30);   -- Tesco (£0.30/lemon)

-- Caster Sugar (ingredient_id = 6)
INSERT INTO prices (ingredient_id, supermarket_id, price_per_unit) VALUES
(6, 1, 0.00149), -- Aldi (£1.49/kg → £0.00149/g)
(6, 2, 0.00350),-- Morrisons (£3.50/kg → £0.00350/g)
(6, 3, 0.00370),-- Waitrose (£3.70/kg → £0.00370/g)
(6, 4, 0.00240), -- Sainsbury’s (£2.40/kg → £0.00240/g)
(6, 5, 0.00225);-- Tesco (£2.25/kg → £0.00225/g)