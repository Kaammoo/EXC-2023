-- Create database
CREATE DATABASE IF NOT EXISTS Cats_wb;

-- Use the created database
USE Cats_wb;

-- Create table
CREATE TABLE IF NOT EXISTS Cats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    breed VARCHAR(100),
    coloration VARCHAR(100),
    age INT,
    fav_toy VARCHAR(100)
);

-- Insert data into the Cats table
INSERT INTO Cats (name, breed, coloration, age, fav_toy) VALUES
('Fluffy', 'Siamese', 'White', 3, 'Feather toy'),
('Max', 'Ragdoll', 'Blue', 5, 'Mouse toy'),
('Bella', 'Persian', 'White', 2, 'Yarn ball'),
('Luna', 'Maine Coon', 'Tabby', 4, 'Scratching post'),
('Simba', 'Bengal', 'Spotted', 1, 'Ball with bell'),
('Oliver', 'Scottish Fold', 'Orange Tabby', 6, 'Catnip mouse'),
('Milo', 'Sphynx', 'Hairless', 2, 'String toy'),
('Chloe', 'British Shorthair', 'Gray', 4, 'Furry mouse'),
('Lucy', 'American Shorthair', 'Calico', 3, 'Feather wand'),
('Leo', 'Norwegian Forest', 'Tuxedo', 5, 'Ribbon wand'),
('Sophie', 'Himalayan', 'Flame Point', 2, 'Plush mouse'),
('Shadow', 'Russian Blue', 'Solid Blue', 4, 'Crinkle ball'),
('Tiger', 'Siberian', 'Brown Tabby', 3, 'Rubber ball'),
('Molly', 'Bombay', 'Black', 6, 'String toy'),
('Oscar', 'Devon Rex', 'Curly', 1, 'Catnip ball'),
('Mia', 'Manx', 'White', 4, 'Feather teaser'),
('Charlie', 'Chartreux', 'Gray', 3, 'Yarn ball'),
('Buddy', 'Cornish Rex', 'Cream', 2, 'Mouse toy'),
('Daisy', 'Tonkinese', 'Mink', 5, 'Squeaky mouse'),
('Cleo', 'Turkish Angora', 'White', 4, 'Laser pointer');

-- Select all data from the Cats table
SELECT * FROM Cats;

-- Select name, breed, and coloration columns for cats under 5 years of age
SELECT name, breed, coloration FROM Cats WHERE age < 5;

-- Select ID and name columns for all cats whose breed is Ragdoll
SELECT id, name FROM Cats WHERE breed = 'Ragdoll';

-- Select all data for cats that meet the specified conditions
SELECT * FROM Cats 
WHERE breed LIKE 'R%' 
AND fav_toy LIKE 'ball%' 
AND coloration LIKE '%m';

-- Select all data for cats that meet the specified conditions
SELECT * FROM Cats 
WHERE age >= 10 
AND (breed = 'Ragdoll' OR breed = 'Abyssinian') 
AND fav_toy IS NOT NULL;

