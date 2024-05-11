DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS product;

-- Create the customer table
CREATE TABLE customer (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255)
);

-- Create the product table
CREATE TABLE product (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    quantities INT,
    price DECIMAL(10, 2)
);

-- Create the orders table
CREATE TABLE orders (
    customer_id int,
    product_id int,
    quantities int,
    FOREIGN KEY (customer_id) REFERENCES customer(id),
    FOREIGN KEY (product_id) REFERENCES product(id)
);

-- Insert 10 rows of data into the customer table
INSERT INTO customer (name, email) VALUES
('John Doe', 'john@example.com'),
('Jane Smith', 'jane@example.com'),
('Michael Johnson', 'michael@example.com'),
('Emily Brown', 'emily@example.com'),
('William Taylor', 'william@example.com'),
('Emma Martinez', 'emma@example.com'),
('Daniel Anderson', 'daniel@example.com'),
('Olivia Wilson', 'olivia@example.com'),
('James Garcia', 'james@example.com'),
('Sophia Lopez', 'sophia@example.com');

-- Insert 10 rows of data into the product table
INSERT INTO product (name, quantities, price) VALUES
('Apple', 10, 150),
('Banana', 15, 75),
('Orange', 12, 125),
('Milk', 5, 250),
('Bread', 8, 180),
('Eggs', 6, 200),
('Chicken', 4, 500),
('Rice', 20, 200),
('Potato', 18, 50),
('Tomato', 12, 75);

-- Function is_valid_product_stock
DROP FUNCTION IF EXISTS is_valid_product_stock;

DELIMITER $$
CREATE FUNCTION is_valid_product_stock(prod_id INT, prod_quant INT)
RETURNS INT
BEGIN
    DECLARE isValid INT DEFAULT 0;
    SELECT quantities INTO @quant FROM product
    WHERE id = prod_id;
    IF @quant >= prod_quant then
        SET isValid = 1;
    END IF;
    RETURN isValid;
END $$
DELIMITER ;

-- Trigger insert_order
DROP TRIGGER IF EXISTS insert_order;
DELIMITER $$
CREATE TRIGGER insert_order AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    UPDATE product
    SET quantities = quantities - NEW.quantities
    WHERE id = NEW.product_id;
END$$
DELIMITER ;

-- Procedure Process Order
DROP PROCEDURE IF EXISTS process_order;

DELIMITER $$
CREATE PROCEDURE process_order(
    IN customerID INT,
    IN productID INT,
    IN prod_cuant INT)
BEGIN
    IF is_valid_product_stock(productID, prod_cuant) = 0 then
        SIGNAL SQLSTATE '45001'
        SET MESSAGE_TEXT = 'There is no such amount of this product';
    END IF;
    INSERT INTO orders(customer_id, product_id, quantities)
    VALUES (customerID, productID, prod_cuant);
END$$
DELIMITER ;
