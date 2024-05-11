DROP FUNCTION IF EXISTS calculate_discount;

DELIMITER $$
CREATE FUNCTION calculate_discount(price DECIMAL(10, 2), discount INT)
RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE result DECIMAL;
    SET result = price * (100 - discount) / 100;
    RETURN result;
END$$
DELIMITER ;
