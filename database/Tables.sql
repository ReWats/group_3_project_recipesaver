CREATE DATABASE RecipeSaver;
USE RecipeSaver;

-- Recipes Table (stores saved recipes)
CREATE TABLE recipes (
    recipe_id INT AUTO_INCREMENT PRIMARY KEY,
    recipe_name VARCHAR(255) NOT NULL, -- e.g., "Pancakes"
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Recipe_items Table (user-saved ingredients)
CREATE TABLE recipe_items (
	recipe_id INT NOT NULL, -- Links to the recipes tables via recipe ID (ensure ingredients belong to recipe)
    item_name VARCHAR(255) NOT NULL,
    quantity INT DEFAULT 1,
    price DECIMAL(10,2),
    FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id) ON DELETE CASCADE
);

-- Supermarket_prices Table (empty table to store scraped prices from Octoparse)
CREATE TABLE supermarket_prices (
    price_id INT AUTO_INCREMENT PRIMARY KEY,
    scraped_item_name VARCHAR(255) NOT NULL, -- e.g., "Large Free-Range Eggs"
    quantity VARCHAR(50),        
    price DECIMAL(10,2) NOT NULL,
    supermarket VARCHAR(50) NOT NULL,
    last_updated DATETIME NOT NULL -- When the price was scraped
);
-- Temp ingredients (one-time use, users do not save items as recipes)
CREATE TABLE temp_ingredients (
	temp_id INT AUTO_INCREMENT PRIMARY KEY,
    session_id VARCHAR(255),
    item_name VARCHAR(255) NOT NULL,
    quantity INT DEFAULT 1
);

-- Indexes 
CREATE INDEX idx_recipe_items_recipe_id ON recipe_items(recipe_id);
CREATE INDEX idx_prices_item ON supermarket_prices(scraped_item_name);
CREATE INDEX idx_temp_session ON temp_ingredients(session_id);


