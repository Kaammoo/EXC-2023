-- Create database
CREATE DATABASE IF NOT EXISTS Game_prompt;

-- Use the created database
USE Game_prompt;

-- Create table
CREATE TABLE IF NOT EXISTS Games (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100),
    company VARCHAR(100),
    type VARCHAR(50),
    production_year INT,
    production_cost DECIMAL(10, 2),
    revenue DECIMAL(10, 2),
    rating DECIMAL(3, 1)
);

-- Insert data into the Games table
INSERT INTO Games (title, company, type, production_year, production_cost, revenue, rating) VALUES
('Game4', 'Company4', 'FPS', 2011, 11000.00, 16000.00, 8.0),
('Game5', 'Company5', 'Sports', 2013, 13000.00, 19000.00, 7.5),
('Game6', 'Company6', 'Strategy', 2015, 17000.00, 22000.00, 8.7),
('Game7', 'Company7', 'Action', 2010, 10500.00, 15500.00, 7.9),
('Game8', 'Company8', 'Adventure', 2012, 12500.00, 17500.00, 8.3),
('Game9', 'Company9', 'RPG', 2014, 15500.00, 20500.00, 9.0),
('Game10', 'Company10', 'FPS', 2011, 11500.00, 16500.00, 8.2),
('Game11', 'Company11', 'Sports', 2013, 13500.00, 19500.00, 7.7),
('Game12', 'Company12', 'Strategy', 2015, 17500.00, 22500.00, 8.5),
('Game13', 'Company13', 'Action', 2010, 11000.00, 16000.00, 8.1),
('Game14', 'Company14', 'Adventure', 2012, 13000.00, 18000.00, 8.4),
('Game15', 'Company15', 'RPG', 2014, 16000.00, 21000.00, 9.1),
('Game16', 'Company16', 'FPS', 2011, 12000.00, 17000.00, 8.3),
('Game17', 'Company17', 'Sports', 2013, 14000.00, 20000.00, 7.8),
('Game18', 'Company18', 'Strategy', 2015, 18000.00, 23000.00, 8.6),
('Game19', 'Company19', 'Action', 2010, 11500.00, 16500.00, 8.2),
('Game20', 'Company20', 'Adventure', 2012, 13500.00, 18500.00, 8.5),
('Game21', 'Company21', 'RPG', 2014, 16500.00, 21500.00, 9.2),
('Game22', 'Company22', 'FPS', 2011, 12500.00, 17500.00, 8.4),
('Game23', 'Company23', 'Sports', 2013, 14500.00, 20500.00, 7.9);


-- Select all data by production_cost from cheapest to most expensive. 
-- If several games have the same production_cost, they should be sorted by rating from best to worst.
SELECT * FROM Games ORDER BY production_cost ASC, rating DESC;

-- Select the production_cost column for games produced between 2010 and 2015 and rated above 7. 
-- Sort by cheapest to most expensive price of manufacture.
SELECT production_cost FROM Games WHERE production_year BETWEEN 2010 AND 2015 AND rating > 7 ORDER BY production_cost ASC;

-- Select for each year: production year (production_year), 
-- number of games released per year (use count as the given column name) 
-- annual average production costs per game (use avg_cost as the given column name) 
-- average revenue per game for the year (use avg_revenue as the given column name)
SELECT production_year, COUNT(*) AS number_of_games, AVG(production_cost) AS avg_cost, AVG(revenue) AS avg_revenue 
FROM Games GROUP BY production_year;

-- Count how many games of a given type and produced by a given company were profitable 
-- (that is, the revenue was greater than the cost of production). 
-- Shows the number of games (as number_of_games) and the company.
SELECT company, COUNT(*) AS number_of_games 
FROM Games WHERE revenue > production_cost GROUP BY company;

-- For each company, select its name, the number of games it produces (as number_of_games), 
-- and the average cost of production (as avg_cost). 
-- Show only companies that have produced more than one game.
SELECT company, COUNT(*) AS number_of_games, AVG(production_cost) AS avg_cost 
FROM Games GROUP BY company HAVING COUNT(*) > 1;

