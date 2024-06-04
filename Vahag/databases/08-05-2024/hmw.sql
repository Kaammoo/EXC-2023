CREATE DATABASE Triggers_homework;
USE Triggers_homework;

/* 
1. Create a BEFORE INSERT trigger that will check the age of the added user, 
if we enter a user younger than 18 years old, we should get an error
*/

CREATE TABLE user(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30),
    age INT,
    email VARCHAR(30)
);

DELIMITER $$
CREATE TRIGGER check_age
BEFORE INSERT ON user
FOR EACH ROW
BEGIN
    IF NEW.age < 18 THEN
        SIGNAL SQLSTATE '50001'
        SET MESSAGE_TEXT = 'Person must be older than 18.';
    END IF;
END$$
DELIMITER ;

INSERT INTO user(name, age, email) 
VALUES ('Vahag', 20, 'sargsyan@gmail.com'),
        ('Saqo', 16, 'saqo@gmail.com');


/* 
2. Create an AFTER INSERT trigger that will update the average age 
in the average_age table according to the age of the entered user
*/

CREATE TABLE average_age (
    id INT AUTO_INCREMENT PRIMARY KEY,
    average DECIMAL(5, 2),
    date_modified TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER update_average_age
AFTER INSERT ON user
FOR EACH ROW
BEGIN
    DECLARE avg_age DECIMAL(5, 2);
    SELECT AVG(age) INTO avg_age FROM user;
    INSERT INTO average_age(average, date_modified)
    VALUES (avg_age, CURRENT_TIMESTAMP);
END$$
DELIMITER ;

INSERT INTO user(name, age, email) 
VALUES ('Karlen', 22, 'karlen@gmail.com'),
        ('Anahit', 25, 'anahit@gmail.com');

/* 
3. Create a BEFORE DELETE trigger that will 
add all deleted rows to the person_archive table
*/

CREATE TABLE person_archive (
    user_id INT,
    name VARCHAR(30),
    age INT,
    email VARCHAR(30),
    delaeted_date TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER delete_user
BEFORE DELETE ON user
FOR EACH ROW
BEGIN
    INSERT INTO person_archive(user_id, name, age, email, delaeted_date)
    VALUES(OLD.id, OLD.name, OLD.age, OLD.email, CURRENT_TIMESTAMP);
END$$
DELIMITER ;

DELETE FROM user
WHERE id = 3;

/* 
4. Create an AFTER DELETE trigger that will 
update the average age in the average_age table
*/

DELIMITER $$
CREATE TRIGGER update_average_age_delete
AFTER DELETE ON user
FOR EACH ROW
BEGIN
    DECLARE avg_age DECIMAL(5, 2);
    SELECT AVG(age) INTO avg_age FROM user;
    INSERT INTO average_age(average, date_modified)
    VALUES (avg_age, CURRENT_TIMESTAMP);
END$$
DELIMITER ;

DELETE FROM user
WHERE id = 8;

-- Trigger I wrote in the office
CREATE TABLE info (
    user_id INT,
    action VARCHAR(10),
    date_modified TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER after_insert
AFTER INSERT ON user
FOR EACH ROW
BEGIN
    INSERT INTO info(user_id, action, date_modified)
    VALUES (NEW.id, 'INSERT', CURRENT_TIMESTAMP);
END$$
DELIMITER ;

INSERT INTO user(name, age, email) 
VALUES ('Seyran', 44, 'seyran@gmail.com'),
        ('Kaammoo', 19, 'kamoooo@gmail.com');
