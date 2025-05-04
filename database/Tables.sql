CREATE DATABASE IF NOT EXISTS RecipeSaver;
USE RecipeSaver;

-- Recipes Table (stores saved recipes)
CREATE TABLE IF NOT EXISTS recipes (
    recipe_id INT AUTO_INCREMENT PRIMARY KEY,
    recipe_name VARCHAR(255) NOT NULL, -- e.g., "Pancakes"
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Recipe_items Table (user-saved ingredients)
CREATE TABLE IF NOT EXISTS recipe_items (
	recipe_item_id INT AUTO_INCREMENT PRIMARY KEY,
	recipe_id INT NOT NULL, -- Links to the recipes tables via recipe ID (ensure ingredients belong to recipe)
    item_name VARCHAR(255) NOT NULL,
    quantity DECIMAL(10,2) DEFAULT 1,
    unit VARCHAR(50) DEFAULT 'each',
    estimated_price_at_save DECIMAL(10,2) NULL,
    FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id) ON DELETE CASCADE
);

-- Supermarket_prices Table (empty table to store live scraped prices)
CREATE TABLE IF NOT EXISTS supermarket_prices (
    price_id INT AUTO_INCREMENT PRIMARY KEY,
    scraped_item_name VARCHAR(255) NOT NULL, -- e.g., "Large Free-Range Eggs"
    quantity VARCHAR(50),        
    price DECIMAL(10,2) NOT NULL,
    supermarket VARCHAR(50) NOT NULL,
    last_updated DATETIME NOT NULL -- When the price was scraped
);
-- Temp ingredients (one-time use, users do not save items as recipes)
CREATE TABLE IF NOT EXISTS temp_ingredients (
	temp_id INT AUTO_INCREMENT PRIMARY KEY,
    session_id VARCHAR(255),
    item_name VARCHAR(255) NOT NULL,
    quantity DECIMAL (10,2) DEFAULT 1,
    unit VARCHAR(50) DEFAULT 'each'
);

-- Indexes 
CREATE INDEX idx_recipe_items_recipe_id ON recipe_items(recipe_id);
CREATE INDEX idx_prices_item ON supermarket_prices(scraped_item_name);
CREATE INDEX idx_temp_session ON temp_ingredients(session_id);

-- Sample data: Pancake Recipe
INSERT INTO recipes (recipe_name)
VALUES
('Pancake Recipe');
SET @pancake_id = LAST_INSERT_ID();

INSERT INTO recipe_items(recipe_id, item_name, quantity, unit)
VALUES
(@pancake_id, 'Plain flour', 100, 'g'),
(@pancake_id, 'Whole milk', 300, 'ml'),
(@pancake_id, 'Large eggs', 2, 'each'),
(@pancake_id, 'Sunflower oil', 1, 'tbsp'),
(@pancake_id, 'Lemon', 1, 'each'),
(@pancake_id, 'Caster sugar', 20, 'g');

-- Stored procedure: cheapest single-store total
DELIMITER $$
CREATE PROCEDURE get_cheapest_store(IN sess_id VARCHAR(255))
BEGIN
    SELECT
       sp.supermarket,
       SUM(sp.price) AS total_cost

      FROM temp_ingredients ti
      JOIN supermarket_prices sp
        ON sp.scraped_item_name = ti.item_name
       WHERE ti.session_id = sess_id
        AND sp.last_updated > NOW() - INTERVAL 1 HOUR
       GROUP BY sp.supermarket
       ORDER BY total_cost
       LIMIT 1;
      END $$
      DELIMITER ;

-- Stored procedure: Cheapest per-item breakdown
DELIMITER $$
CREATE PROCEDURE get_cheapest_per_item(IN sess_id VARCHAR(255))
BEGIN
  SELECT
    ti.item_name,
    MIN(sp.price)                     AS cheapest_price,
    SUBSTRING_INDEX(
      GROUP_CONCAT(
        sp.supermarket
        ORDER BY sp.price ASC
        SEPARATOR ','
      ), ',', 1
    )                                  AS cheapest_supermarket
  FROM temp_ingredients ti
  JOIN supermarket_prices sp
    ON sp.scraped_item_name = ti.item_name
  WHERE ti.session_id = sess_id
  GROUP BY ti.item_name;
END $$
DELIMITER ;





