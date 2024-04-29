CREATE TABLE cats(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20),
    breed VARCHAR(20),
    coloration VARCHAR(20),
    age INT,
    fav_toy VARCHAR(20)
);

INSERT INTO cats (name, breed, coloration, age, fav_toy)
VALUES ('Whiskers', 'Abyssinian', 'Tabby', 13, 'Feather'),
('Mittens', 'Persian', 'White', 5, 'ball'),
('Fluffy', 'Ragdoll', 'Chocolatem Point', 12, ''),
('Max', 'Scottish Fold', 'Bluem', 4, 'ball');

-- 3
SELECT * FROM cats;

-- 4
SELECT name, breed, coloration FROM cats WHERE age < 5;

-- 5
SELECT id, name FROM cats WHERE breed = 'Ragdoll';

-- 6
SELECT * FROM cats
WHERE breed LIKE 'R%' AND fav_toy LIKE 'ball%' AND coloration LIKE '%m';

-- 7
SELECT * FROM cats
WHERE age > 10
AND (breed LIKE 'Ragdoll' OR breed LIKE 'Abyssinian')
AND fav_toy IS NOT NULL AND fav_toy <> '';
