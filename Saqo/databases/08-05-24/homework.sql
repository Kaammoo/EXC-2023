DROP TABLE IF EXISTS user;
CREATE TABLE user (
    id int auto_increment primary key,
    name varchar(20),
    surname varchar(20),
    user_age int
);

DROP TABLE IF EXISTS average_age;
CREATE TABLE average_age (
    id int auto_increment primary key,
    av_age int DEFAULT 0,
    date_modified TIMESTAMP
);

DROP TABLE IF EXISTS person_archive;
CREATE TABLE person_archive (
    user_id int,
    name varchar(20),
    surname varchar(20),
    user_age int,
    deleted_date TIMESTAMP
);

-- BEFORE INSERT TRIGGER
DROP TRIGGER IF EXISTS before_insert_user;
DELIMITER $$

CREATE TRIGGER before_insert_user
BEFORE INSERT ON user
FOR EACH ROW
BEGIN
    IF NEW.user_age < 18 THEN
        SIGNAL SQLSTATE '50001'
        SET MESSAGE_TEXT = 'Person must be older than 18.';
    END IF;
END $$

DELIMITER ;

-- AFTER INSERT TRIGGER
DROP TRIGGER IF EXISTS after_insert_user;

DELIMITER $$

CREATE TRIGGER after_insert_user
BEFORE INSERT ON user
FOR EACH ROW
BEGIN
    SELECT COUNT(user_age) INTO @user_count FROM user;
    IF @user_count = 0 THEN
        INSERT INTO average_age(av_age, date_modified)
        VALUES (NEW.user_age, CURRENT_TIMESTAMP);
    ELSE
        SELECT SUM(user_age) INTO @sum_age FROM user;
        SET @average = (@sum_age + NEW.user_age) / (@user_count + 1);
        INSERT INTO average_age(av_age, date_modified)
        VALUES (@average, CURRENT_TIMESTAMP);
    END IF;
END $$

DELIMITER ;


-- BEFORE DELETE TRIGGER
DROP TRIGGER IF EXISTS before_delete_user;

DELIMITER $$

CREATE TRIGGER before_delete_user
BEFORE DELETE ON user
FOR EACH ROW
BEGIN
    INSERT INTO person_archive(user_id, name, surname, user_age, deleted_date)
    VALUES(OLD.id, OLD.name, OLD.surname, OLD.user_age, CURRENT_TIMESTAMP);
END$$
DELIMITER ;

-- AFTER DELETE TRIGGER
DROP TRIGGER IF EXISTS after_delete_user;

DELIMITER $$

CREATE TRIGGER after_delete_user
AFTER DELETE ON user
FOR EACH ROW
BEGIN
    SELECT COUNT(user_age) INTO @count_age FROM user;
    IF @count_age = 0 THEN
        INSERT INTO average_age(av_age, date_modified)
        VALUES (0, CURRENT_TIMESTAMP);
    ELSE
        SELECT AVG(user_age) INTO @average FROM user;
        INSERT INTO average_age(av_age, date_modified)
        VALUES (@average, CURRENT_TIMESTAMP);
    END IF;
END$$
DELIMITER ;

-- OFICE

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
