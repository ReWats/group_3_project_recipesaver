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

-- Indexes
CREATE INDEX idx_recipe_items_recipe_id ON recipe_items(recipe_id);

-- Sample data: Pancake Recipe
INSERT INTO recipes (recipe_name)
VALUES
('Pancake Recipe');
SET @pancake_id = LAST_INSERT_ID();

INSERT INTO recipe_items(recipe_id, item_name, quantity, unit)
VALUES
(@pancake_id, 'Plain flour', 0.1, 'kg'),
(@pancake_id, 'Whole milk', 0.3, 'l'),
(@pancake_id, 'Large eggs', 2, 'each'),
(@pancake_id, 'Sunflower oil', 1, 'tbsp'),
(@pancake_id, 'Lemon', 1, 'each'),
(@pancake_id, 'Caster sugar', 0.02, 'kg');
