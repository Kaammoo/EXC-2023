CREATE TABLE Games (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    company VARCHAR(255),
    type VARCHAR(255),
    production_year INT,
    production_cost DECIMAL(15, 2),
    revenue DECIMAL(15, 2),
    rating FLOAT
);

INSERT INTO Games (title, company, type, production_year, production_cost, revenue, rating) VALUES
('Red Dead Redemption 2', 'Rockstar Games', 'Action-Adventure', 2018, 100000000.00, 725000000.00, 9.8),
('Minecraft', 'Mojang Studios', 'Sandbox', 2011, 10000000.00, 2500000000.00, 9.0),
('Fortnite', 'Epic Games', 'Rockstar Games', 2017, 13000000.00, 9000000000.00, 8.5),
('Counter-Strike: Global Offensive', 'Valve', 'First-Person Shooter', 2012, 4000000.00, 1500000000.00, 9.0),
('The Elder Scrolls V: Skyrim', 'Bethesda Game Studios', 'Action RPG', 2011, 85000000.00, 500000000.00, 9.3),
('League of Legends', 'Riot Games', 'MOBA', 2009, 15000000.00, 2500000000.00, 8.5),
('Overwatch', 'Blizzard Entertainment', 'First-Person Shooter', 2016, 160000000.00, 1500000000.00, 8.0),
('Pokémon Sword and Shield', 'Nintendo', 'Role-Playing Game', 2019, 150000000.00, 1800000000.00, 8.7),
('FIFA 21', 'EA Sports', 'Sports', 2020, 300000000.00, 2500000000.00, 7.8),
('Among Us', 'InnerSloth', 'Party', 2018, 500000.00, 50000000.00, 8.5);

SELECT * FROM Games ORDER BY production_cost ASC, rating DESC;

SELECT production_cost FROM Games WHERE production_year BETWEEN 2010 AND 2015 AND rating >= 7 ORDER BY production_cost ASC;

SELECT production_year, COUNT(*) AS count, AVG(production_cost) AS avg_cost, AVG(revenue) AS avg_revenue FROM Games GROUP BY production_year;

SELECT type, company, COUNT(*) AS number_of_games FROM Games WHERE revenue > production_cost GROUP BY type, company;

SELECT company, COUNT(*) AS number_of_games, AVG(production_cost) AS avg_cost FROM Games GROUP BY company HAVING number_of_games > 1;

