-- to execute all of this code I need delimiter
-- you can use any delimiter: , // ##
-- after you create a SP, you can't edit it. 
-- if you want to edit, first drop, create new

use classicmodels;

DELIMITER //

CREATE PROCEDURE GetAllProducts()
BEGIN
	SELECT *  FROM products;
    select * from orders;
END //

DELIMITER ;

DROP PROCEDURE IF EXISTS GetAllProducts;
-- Executing the stored procedure
CALL GetAllProducts();

DROP PROCEDURE IF EXISTS GetOfficeByCountry;

DELIMITER //

CREATE PROCEDURE GetOfficeByCountry(
	IN countryName VARCHAR(255)
)
BEGIN
	SELECT * 
 		FROM offices
			WHERE country = countryName;
END //
DELIMITER ;

CALL GetOfficeByCountry('USA');

CALL GetOfficeByCountry('France');

-- error: no arg
CALL GetOfficeByCountry();

-- Exercise1
-- Create a stored procedure which displays the first X entries of payment table. 
-- X is IN parameter for the procedure.
DELIMITER //

CREATE PROCEDURE GetXPayments(
	IN numberOfEntries INT
)
BEGIN
	SELECT * 
 		FROM payments
			LIMIT numberOfEntries;
END //
DELIMITER ;

CALL GetXPayments(10);

DROP PROCEDURE IF EXISTS GetOrderCountByStatus;

DELIMITER $$

CREATE PROCEDURE GetOrderCountByStatus (
	IN  orderStatus VARCHAR(25),
	OUT total INT
)
BEGIN
	SELECT COUNT(orderNumber)
	INTO total
	FROM orders
	WHERE status = orderStatus;
END$$
DELIMITER ;

CALL GetOrderCountByStatus('Shipped',@total);
SELECT @total;

-- Exercise2
-- Create a stored procedure which returns the amount for Xth entry of payment table. 
-- X is IN parameter for the procedure. Display the returned amount.
DROP PROCEDURE IF EXISTS GetAmountOfPayment;
-- returnAmount should be DECIMAL(10,2), because that's the data type of amount column
DELIMITER $$

CREATE PROCEDURE GetAmountOfPayment (
	IN  nthEntry INT,
	OUT returnAmount INT
)
BEGIN
	SELECT amount
	INTO returnAmount
	FROM payments
	LIMIT nthEntry, 1;
END$$
DELIMITER ;

CALL GetAmountOfPayment(5, @returnAmount);
call anotherProcedure(@returnAmount);
SELECT @returnAmount;

DROP PROCEDURE IF EXISTS SetCounter;

DELIMITER $$

CREATE PROCEDURE SetCounter(
	INOUT counter INT,
    	IN inc INT
)
BEGIN
	SET counter = counter + inc;
END$$
DELIMITER ;

SET @counter = 1;
CALL SetCounter(@counter,1); 
SELECT @counter;
CALL SetCounter(@counter,1); 
SELECT @counter;
CALL SetCounter(@counter,1); 
SELECT @counter;

DROP PROCEDURE IF EXISTS GetCustomerLevel;

DELIMITER $$

CREATE PROCEDURE GetCustomerLevel(
    	IN  pCustomerNumber INT, 
    	OUT pCustomerLevel  VARCHAR(20)
)
BEGIN
	DECLARE credit DECIMAL DEFAULT 0;

	SELECT creditLimit 
		INTO credit
			FROM customers
				WHERE customerNumber = pCustomerNumber;

	IF credit > 50000 THEN
		SET pCustomerLevel = 'PLATINUM';
	ELSE
		SET pCustomerLevel = 'NOT PLATINUM';
	END IF;
END$$
DELIMITER ;

CALL GetCustomerLevel(447, @level);
SELECT @level;

-- Exercise3
-- Create a stored procedure which returns category of a given row. 
-- Row number is IN parameter, while category is OUT parameter. Display the returned category.
-- CAT1 - amount > 100.000, CAT2 - amount > 10.000, CAT3 - amount <= 10.000		
DROP PROCEDURE IF EXISTS GetCategoryOfRow;

DELIMITER $$

CREATE PROCEDURE GetCategoryOfRow(
    	IN  rowNumber INT, 
    	OUT category VARCHAR(20)
)
BEGIN

	DECLARE amountToUse DECIMAL DEFAULT 0;
	SELECT amount 
		INTO amountToUse
			FROM payments
				LIMIT rowNumber, 1;

	IF amountToUse >= 10000 THEN
		SET category = 'CAT3';
	ELSEIF amountToUse > 10000 THEN
		SET category = 'CAT2';
	ELSEIF amountToUse > 100000 THEN
		SET category = 'CAT1';
	END IF;
END$$
DELIMITER ;

CALL GetCategoryOfRow(3, @category);
SELECT @category;