DROP TABLE IF EXISTS user;

CREATE TABLE user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    email VARCHAR(50),
    password VARCHAR(255)
);

--1.1 point, function for validate the user password
DROP FUNCTION IF EXISTS is_valid_password;

DELIMITER //

CREATE FUNCTION is_valid_password(pass VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE is_valid INT;

    IF CHAR_LENGTH(pass) < 8 THEN
       SET is_valid = 0;
       RETURN is_valid;
    END IF;

    IF NOT (pass REGEXP '[[:upper:]]' AND
            pass REGEXP '[[:lower:]]' AND
            pass REGEXP '[[:digit:]]' AND
            pass REGEXP '[[:punct:]]') THEN
        SET is_valid = 0;
        RETURN is_valid;
    END IF;

    SET is_valid = 1;
    RETURN is_valid;
END//

DELIMITER ;

/* 
Examples

mysql> SELECT is_valid_password('qwerty');
+-----------------------------+
| is_valid_password('qwerty') |
+-----------------------------+
|                           0 |
+-----------------------------+
1 row in set (0.00 sec)

mysql> SELECT is_valid_password('karginSeyral1');
+------------------------------------+
| is_valid_password('karginSeyral1') |
+------------------------------------+
|                                  0 |
+------------------------------------+
1 row in set (0.01 sec)

mysql> SELECT is_valid_password('As1#');
+---------------------------+
| is_valid_password('As1#') |
+---------------------------+
|                         0 |
+---------------------------+
1 row in set (0.00 sec)

mysql> SELECT is_valid_password('Qwert123!');
+--------------------------------+
| is_valid_password('Qwert123!') |
+--------------------------------+
|                              1 |
+--------------------------------+
1 row in set (0.00 sec)

*/

--1.2 point, function for hashing password
DROP FUNCTION IF EXISTS HashPassword;

DELIMITER //

CREATE FUNCTION HashPassword(_password VARCHAR(50))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE _hashedPassword VARCHAR(255);
    SET _hashedPassword = SHA2(_password, 256);
    RETURN _hashedPassword;
END//

DELIMITER ;

--Procedure for creating user
DROP PROCEDURE IF EXISTS create_user;

DELIMITER //

CREATE PROCEDURE create_user(
    IN u_email VARCHAR(50),
    IN pass VARCHAR(50),
    IN f_n VARCHAR(30),
    IN l_n VARCHAR(30)
)
BEGIN
    DECLARE hashed_pass VARCHAR(255);
    IF is_valid_email(u_email) = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Invalid email';
    END IF;

    IF is_valid_password(pass) = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Invalid password';
    END IF;

    SET hashed_pass = HashPassword(pass);

    INSERT INTO user(first_name, last_name, email, password)
    VALUES (f_n, l_n, u_email, hashed_pass);
END//

DELIMITER ;

/*
Example
CALL create_user('sadasjh@gmail', 'asda', 'Vahag', 'Sargsyan');
ERROR 1644 (45000): Invalid email
mysql> CALL create_user('sadasjh@gmail.com', 'asda', 'Vahag', 'Sargsyan');
ERROR 1644 (45000): Invalid password
mysql> CALL create_user('sadasjh@gmail.com', 'Qwerty123!', 'Vahag', 'Sargsyan');
Query OK, 1 row affected (0.02 sec)

mysql> SELECT * FROM user;
+----+------------+-----------+-------------------+------------------------------------------------------------------+
| id | first_name | last_name | email             | password                                                         |
+----+------------+-----------+-------------------+------------------------------------------------------------------+
|  1 | Vahag      | Sargsyan  | sadasjh@gmail.com | 3875034e17855bac03a3cc9e107b1d28a9b44313d381c3335588525b4e70b55b |
+----+------------+-----------+-------------------+------------------------------------------------------------------+
1 row in set (0.00 sec)

*/