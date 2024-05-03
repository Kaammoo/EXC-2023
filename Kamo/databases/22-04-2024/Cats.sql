CREATE TABLE Cats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    breed VARCHAR(50),
    coloration VARCHAR(50),
    age INT,
    fav_toy VARCHAR(100)
);

INSERT INTO Cats (name, breed, coloration, age, fav_toy) VALUES
('Fluffy', 'Siamese', 'Seal point', 3, 'Feather wand'),
('Whiskers', 'Ragdoll', 'Blue mitted', 5, 'Mouse toy'),
('Mittens', 'Maine Coon', 'Tabby', 2, 'Ball of yarn');

SELECT * FROM Cats;

SELECT name, breed, coloration FROM Cats WHERE age <= 5;

SELECT id, name FROM Cats WHERE breed = 'Ragdoll';

SELECT * FROM Cats WHERE breed LIKE 'R%' AND fav_toy LIKE 'ball%' AND coloration LIKE '%m';

SELECT * FROM Cats WHERE age >= 10 AND (breed = 'Ragdoll' OR breed = 'Abyssinian') AND fav_toy IS NOT NULL;


