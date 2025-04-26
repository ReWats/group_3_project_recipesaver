USE recipesaver_db;

-- Insert some supermarkets
INSERT INTO supermarkets(name, website_url) VALUES 
('Aldi', 'https://www.aldi.co.uk/'),
('Morrisons', 'https://www.morrisons.com/'),
('Waitrose', 'https://www.waitrose.com/'),
('Sainsburys', 'https://www.sainsburys.co.uk/'),
('Tesco', 'https://www.tesco.com/');

-- Insert pancake ingredients
INSERT INTO ingredients(name, unit, description) VALUES
('Plain flour', 'g', 'Price per gram'),
('Large eggs', 'each', 'Price per egg'),
('Whole milk', 'ml', 'Price per millilitre'),
('Sunflower oil', 'ml', 'Price per millilitre'),
('Lemon', 'each', 'Price per lemon'),
('Caster sugar', 'g', 'Price per gram');

-- Insert pancake ingredient prices
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

-- Create test user
INSERT INTO users (username, email, password) VALUES
('test_user', 'test@recipesaver.com', 'testpassword');

-- Create sample recipe 
INSERT INTO recipes (user_id, name) VALUES
(1, 'Pancake Mix');

-- Link ingredients to recipe
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity) VALUES
(1,1,100),
(1,2,2),
(1,3,300),
(1,4,15),
(1,5,1),
(1,6,20);




