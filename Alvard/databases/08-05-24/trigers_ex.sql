CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    age INT
);

CREATE TABLE average_age (
    avg_age DECIMAL(5,2)
);

CREATE TABLE person_archive (
    id INT,
    name VARCHAR(100),
    age INT
);


-- Trigger for age validation before insert
DELIMITER //
CREATE TRIGGER before_insert_age_check
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
    IF NEW.age < 18 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot insert user younger than 18 years old';
    END IF;
END //
DELIMITER ;

-- Trigger to update average age after insert
DELIMITER //
CREATE TRIGGER after_insert_update_average_age
AFTER INSERT ON users
FOR EACH ROW
BEGIN
    DECLARE total_age INT;
    DECLARE total_users INT;
    SELECT SUM(age), COUNT(*) INTO total_age, total_users FROM users;
    UPDATE average_age SET avg_age = total_age / total_users;
END //
DELIMITER ;

-- Trigger to archive deleted rows before delete
DELIMITER //
CREATE TRIGGER before_delete_archive_rows
BEFORE DELETE ON users
FOR EACH ROW
BEGIN
    INSERT INTO person_archive (id, name, age) VALUES (OLD.id, OLD.name, OLD.age);
END //
DELIMITER ;

-- Trigger to update average age after delete
DELIMITER //
CREATE TRIGGER after_delete_update_average_age
AFTER DELETE ON users
FOR EACH ROW
BEGIN
    DECLARE total_age INT;
    DECLARE total_users INT;
    SELECT SUM(age), COUNT(*) INTO total_age, total_users FROM users;
    UPDATE average_age SET avg_age = total_age / total_users;
END //
DELIMITER ;

