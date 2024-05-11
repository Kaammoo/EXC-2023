CREATE TABLE customer (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(50),
    email VARCHAR(50)
);

CREATE TABLE product (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    count INT,
    price DECIMAL(10, 2)
);

CREATE TABLE orders (
    customer_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES customer(id),
    FOREIGN KEY (product_id) REFERENCES product(id)
);

INSERT INTO customer (full_name, email) VALUES
('John Doe', 'john@example.com'),
('Jane Smith', 'jane@example.com'),
('Michael Johnson', 'michael@example.com'),
('Emily Brown', 'emily@example.com'),
('William Wilson', 'william@example.com'),
('Emma Taylor', 'emma@example.com'),
('Daniel Martinez', 'daniel@example.com');

INSERT INTO product (name, count, price) VALUES
('Product 1', 10, 25.99),
('Product 2', 5, 39.99),
('Product 3', 20, 15.49),
('Product 4', 8, 49.99),
('Product 5', 15, 29.99),
('Product 6', 3, 79.99),
('Product 7', 12, 9.99);

INSERT INTO orders (customer_id, product_id, quantity) VALUES
(1, 1, 2),
(1, 3, 1),
(2, 2, 3),
(3, 4, 1),
(4, 5, 2),
(5, 6, 1),
(6, 7, 4);

--2.4 point, create trigger after inserting into orders
DELIMITER //

CREATE TRIGGER update_product
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    DECLARE qnt INT;

    SELECT count INTO qnt FROM product WHERE id = NEW.product_id;
    UPDATE product SET count = qnt - NEW.quantity WHERE id = NEW.product_id;
END//

DELIMITER ;

--2.1 point, create function for validate the order details
DROP FUNCTION IF EXISTS is_valid_product_stock;

DELIMITER //

CREATE FUNCTION is_valid_product_stock(pr_id INT, qnt INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE is_valid INT;

    DECLARE pr_qnt INT;
    SELECT count INTO pr_qnt FROM product WHERE pr_id = id;
    IF qnt >= pr_qnt THEN
        SET is_valid = 0;
    ELSE
        SET is_valid = 1;
    END IF;
    RETURN is_valid;
END//

DELIMITER ;

/*
Example
mysql> SELECT is_valid_product_stock(3, 18);
+-------------------------------+
| is_valid_product_stock(3, 18) |
+-------------------------------+
|                             1 |
+-------------------------------+
1 row in set (0.00 sec)

mysql> SELECT is_valid_product_stock(6, 10);
+-------------------------------+
| is_valid_product_stock(6, 10) |
+-------------------------------+
|                             0 |
+-------------------------------+
1 row in set (0.00 sec)

*/


--Procedure, for doing order process
DELIMITER //

CREATE PROCEDURE process_order(
    IN cst_id INT,
    IN pr_id INT,
    IN qnt INT
)
BEGIN
    IF is_valid_product_stock(pr_id, qnt) = 0 THEN
        SIGNAL SQLSTATE '45001'
        SET MESSAGE_TEXT = 'There is no such amount of this product';
    ELSE
        INSERT INTO orders(customer_id, product_id, quantity) 
        VALUES (cst_id, pr_id, qnt);
    END IF;
END//

DELIMITER ;

/* 
Example
mysql> SELECT * FROM product;
+----+-----------+-------+-------+
| id | name      | count | price |
+----+-----------+-------+-------+
|  1 | Product 1 |     7 | 25.99 |
|  2 | Product 2 |     5 | 39.99 |
|  3 | Product 3 |    20 | 15.49 |
|  4 | Product 4 |     8 | 49.99 |
|  5 | Product 5 |    15 | 29.99 |
|  6 | Product 6 |     3 | 79.99 |
|  7 | Product 7 |    12 |  9.99 |
+----+-----------+-------+-------+
7 rows in set (0.00 sec)

mysql> CALL process_order(2, 5, 20);
ERROR 1644 (45001): There is no such amount of this product
mysql> CALL process_order(2, 5, 5);
Query OK, 1 row affected (0.01 sec)

mysql> SELECT * FROM product;
+----+-----------+-------+-------+
| id | name      | count | price |
+----+-----------+-------+-------+
|  1 | Product 1 |     7 | 25.99 |
|  2 | Product 2 |     5 | 39.99 |
|  3 | Product 3 |    20 | 15.49 |
|  4 | Product 4 |     8 | 49.99 |
|  5 | Product 5 |    10 | 29.99 |
|  6 | Product 6 |     3 | 79.99 |
|  7 | Product 7 |    12 |  9.99 |
+----+-----------+-------+-------+
7 rows in set (0.00 sec)

*/