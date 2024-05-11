--Function for calculating price with discount
DROP FUNCTION IF EXISTS calculate_discount;

DELIMITER //

CREATE FUNCTION calculate_discount(pr_price DECIMAL(10, 2), discount INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE pr_disc DECIMAL(10, 2);
    SET pr_disc = pr_price * discount / 100;
    RETURN pr_price - pr_disc;
END//

DELIMITER ;

/* 
Examples
mysql> SELECT calculate_discount(100, 5);
+----------------------------+
| calculate_discount(100, 5) |
+----------------------------+
|                      95.00 |
+----------------------------+
1 row in set (0.00 sec)

mysql> SELECT calculate_discount(2500.10, 24);
+---------------------------------+
| calculate_discount(2500.10, 24) |
+---------------------------------+
|                         1900.08 |
+---------------------------------+
1 row in set (0.00 sec)

*/