-- Stored Procedure: create_user
DELIMITER //

CREATE PROCEDURE create_user(
    IN p_email VARCHAR(255),
    IN p_password VARCHAR(255),
    IN p_first_name VARCHAR(100),
    IN p_last_name VARCHAR(100)
)
BEGIN
    DECLARE hashed_password VARCHAR(255);
    
    -- Validate email format
    IF NOT is_valid_email(p_email) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid email format';
    END IF;
    
    -- Hash password using bcrypt
    SET hashed_password = bcrypt(p_password, 12);
    
    -- Insert new user record
    INSERT INTO users (email, password, first_name, last_name)
    VALUES (p_email, hashed_password, p_first_name, p_last_name);
END //

DELIMITER ;


-- Stored Procedure: process_order
DELIMITER //

CREATE PROCEDURE process_order(
    IN p_customer_id INT,
    IN p_product_ids INT,
    IN p_quantities INT
)
BEGIN
    -- Validate order details (e.g., sufficient product stock)
    
    -- Create new order record
    INSERT INTO orders (customer_id, product_ids, quantities)
    VALUES (p_customer_id, p_product_ids, p_quantities);
    
END //

DELIMITER ;


-- Function: is_valid_email
DELIMITER //

CREATE FUNCTION is_valid_email(p_email VARCHAR(255))
RETURNS BOOLEAN
BEGIN
    DECLARE is_valid BOOLEAN DEFAULT FALSE;
    
    
    RETURN is_valid;
END //

DELIMITER ;


-- Function: calculate_discount
DELIMITER //

CREATE FUNCTION calculate_discount(p_price DECIMAL(10,2), p_discount DECIMAL(5,2))
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE discounted_price DECIMAL(10,2);
    
    -- Calculate discounted price
    SET discounted_price = p_price * (1 - (p_discount / 100));
    
    RETURN discounted_price;
END //

DELIMITER ;

