CREATE DATABASE Triggers;
USE Triggers;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    age INT NOT NULL
);

DROP TABLE IF EXISTS average_age;
CREATE TABLE average_age (
    id INT AUTO_INCREMENT PRIMARY KEY,
    average INT,
    date TIMESTAMP
);

DROP TABLE IF EXISTS user_archive;
CREATE TABLE user_archive (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255)  NOT NULL,
    age INT  NOT NULL,
    deleted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TRIGGER IF EXISTS age_check_trigger;

DELIMITER //

CREATE TRIGGER age_check_trigger BEFORE INSERT ON users
FOR EACH ROW
BEGIN
    IF NEW.age < 18 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Person must be older than 18.';
    END IF;
END;//

DELIMITER ;

DROP TRIGGER IF EXISTS after_insert_user;

DELIMITER //

CREATE TRIGGER after_insert_user
AFTER INSERT ON users
FOR EACH ROW
BEGIN
    DECLARE avg_age INT;
    SELECT AVG(age) INTO avg_age FROM users;
    INSERT INTO average_age (average, date) VALUES (avg_age, NOW());
END;//

DELIMITER ;

DROP TRIGGER IF EXISTS before_delete_user;

DELIMITER //

CREATE TRIGGER before_delete_user
BEFORE DELETE ON users
FOR EACH ROW
BEGIN
    INSERT INTO user_archive (username, age, deleted_at)
    VALUES (OLD.username, OLD.age, NOW());
END;//

DELIMITER ;

DROP TRIGGER IF EXISTS after_delete_user;

DELIMITER //

CREATE TRIGGER after_delete_user
AFTER DELETE ON users
FOR EACH ROW
BEGIN
    DECLARE avg_age INT;
    SELECT AVG(age) INTO avg_age FROM users;
    INSERT INTO average_age (average, date) VALUES (avg_age, NOW());
END;//

DELIMITER ;
