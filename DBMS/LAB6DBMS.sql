CREATE DATABASE InventoryManagement;
USE InventoryManagement;

CREATE TABLE inventory (
    pid INT PRIMARY KEY,
    pname VARCHAR(50),
    quantity INT CHECK (quantity >= 0)
);

CREATE TABLE `order` (
    oid INT PRIMARY KEY,
    pid INT,
    quantity INT CHECK (quantity > 0),
    FOREIGN KEY (pid) REFERENCES inventory(pid)
);

DELIMITER $$

CREATE TRIGGER availability_check
BEFORE INSERT ON `order`
FOR EACH ROW
BEGIN
    DECLARE available_quantity INT;

    -- Get the current quantity in stock for the product
    SELECT quantity INTO available_quantity
    FROM inventory
    WHERE pid = NEW.pid;

    -- Check if the available quantity is sufficient
    IF available_quantity IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Product does not exist in inventory.';
    ELSEIF NEW.quantity > available_quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient quantity in inventory.';
    END IF;
END$$

DELIMITER ;

