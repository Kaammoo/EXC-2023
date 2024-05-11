DROP TABLE IF EXISTS user;

CREATE TABLE user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    password VARCHAR(255)
);

-- Create is_valid_email function
drop function if exists is_valid_email;

delimiter $$
create function is_valid_email(email varchar(50))
returns int
begin
    declare isValid int default 0;

    if email like '%@%.%' then
       set isValid = 1;
    end if;
    return isValid;
end $$
delimiter ;

-- Create is_valid_password function
DROP FUNCTION IF EXISTS is_valid_password;

DELIMITER $$

CREATE FUNCTION is_valid_password(password VARCHAR(20))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE isValid INT;
    IF NOT (CHAR_LENGTH(password) >= 8 AND
            password REGEXP '[[:upper:]]' AND
            password REGEXP '[[:lower:]]' AND
            password REGEXP '[[:digit:]]' AND
            password REGEXP '[[:punct:]]') THEN
        SET isValid = 0;
        RETURN isValid;
    END IF;

    SET isValid = 1;
    RETURN isValid;
END $$

DELIMITER ;

-- Pasword Hashing Function
DROP FUNCTION IF EXISTS HashPassword;
DELIMITER $$

CREATE FUNCTION HashPassword(_password VARCHAR(255)) RETURNS VARCHAR(255)
BEGIN
    DECLARE _hashedPassword VARCHAR(255);

    SET _hashedPassword = SHA2(_password, 256); -- Example: Using SHA256 hashing

    RETURN _hashedPassword;
END$$

DELIMITER ;

DROP PROCEDURE IF EXISTS create_user;

-- Create User Procedure
DELIMITER $$
CREATE PROCEDURE create_user(
    IN f_name VARCHAR(50),
    IN l_name VARCHAR(50),
    IN u_email VARCHAR(50),
    IN pass VARCHAR(50)
)
BEGIN
    DECLARE hashedPassword VARCHAR(255);
    IF is_valid_email(u_email) = 0 then
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Email is not valid';
    END IF;

    IF is_valid_password(pass) = 0 then
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Password is not valid';
    END IF;

    SET hashedPassword = HashPassword(pass);
    INSERT INTO user(first_name, last_name, email, password)
    VALUES (f_name, l_name, u_email, hashedPassword);
END $$
DELIMITER ;
