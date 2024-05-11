DROP FUNCTION IF EXISTS is_valid_email;

DELIMITER //

CREATE FUNCTION is_valid_email(u_email VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE is_valid INT;
    
    IF u_email LIKE '%@gmail.com' OR
       u_email LIKE '%@mail.ru' OR
       u_email LIKE '%@yandex.ru' OR
       u_email LIKE '%@bk.ru' OR
       u_email LIKE '%@inbox.ru' THEN
        SET is_valid = 1;
    ELSE
        SET is_valid = 0;
    END IF;
    
    RETURN is_valid;
END//

DELIMITER ;

/* 
Examples

SELECT is_valid_email('dasasda@gmail.com');
+-------------------------------------+
| is_valid_email('dasasda@gmail.com') |
+-------------------------------------+
|                                   1 |
+-------------------------------------+
1 row in set (0.00 sec)

mysql> SELECT is_valid_email('dasasda@gmail.co');
+------------------------------------+
| is_valid_email('dasasda@gmail.co') |
+------------------------------------+
|                                  0 |
+------------------------------------+
1 row in set (0.00 sec)

mysql> SELECT is_valid_email('dasasda@mail.com');
+------------------------------------+
| is_valid_email('dasasda@mail.com') |
+------------------------------------+
|                                  0 |
+------------------------------------+
1 row in set (0.00 sec)

mysql> SELECT is_valid_email('dasasda@mail.ru');
+-----------------------------------+
| is_valid_email('dasasda@mail.ru') |
+-----------------------------------+
|                                 1 |
+-----------------------------------+
1 row in set (0.00 sec)

*/