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
	price_id INT AUTO_INCREMENT PRIMARY KEY,
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

-- Indexes for performance
CREATE INDEX idx_prices_ingredient_supermarket ON prices(ingredient_id, supermarket_id);
CREATE INDEX idx_shopping_list ON shopping_list_items(list_id);



