-- Queries that answers to specific analytical questions


-- Order with highest paid amount
SELECT * FROM product_sales ORDER BY Paid_Amount DESC LIMIT 1;

-- What was the cost of the order with highest paid amount?
SELECT (MAX(Paid_Amount)) FROM product_sales;
-- Answer: 13664.08

-- Top 100 Orders with the highest paid amount
SELECT * FROM product_sales ORDER BY Paid_Amount DESC LIMIT 100;

-- Select customer cities starting with 'A'
SELECT DISTINCT Customers_City FROM product_sales WHERE Customers_City LIKE 'a%' ORDER BY Customers_City;

-- From which cities the orders were made with Paid Amount higher than 5000?
SELECT * FROM product_sales WHERE Paid_Amount > 5000 ORDER BY Customers_City;

-- From which cities the baby products with Paid Amount higher than 2000 were ordered?
SELECT * FROM product_sales WHERE Paid_Amount > 2000 AND Category = 'bebes' ORDER BY Customers_City;

-- Show all orders made between 2016 and 2018
SELECT * FROM product_sales WHERE YEAR(product_sales.Ordered_Date) BETWEEN 2016 AND 2018 ORDER BY Ordered_Date; 

-- Show orders by dividing them into 3 price categories: 'NO PRICE', 'MEDIUM PRICE', 'HIGH PRICE'
SELECT TransactionId, Paid_Amount, Product, Category, Customers_City, Customers_State, Ordered_Date,
    CASE 
        WHEN Paid_Amount  = 0
            THEN 'NO PRICE'
        WHEN  Paid_Amount > 0 AND Paid_Amount < 1000
            THEN 'MEDIUM PRICE'
        ELSE 
            'HIGH PRICE'
    END
    AS price_category   
FROM  product_sales
ORDER BY price_category;

-- What is the sum of all Paid Amounts of all orders?
SELECT SUM(Paid_Amount) FROM product_sales;
-- Answer: 47538840.51

-- What is the average (mean) of Paid Amount of all orders?
SELECT AVG(Paid_Amount) AS Average_Paid_Amount FROM product_sales;
-- Answer: 153.76

-- Orders with maximum Paid Amount grouped by cities and ordered by Paid Amount in descending order
SELECT TransactionId, MAX(Paid_Amount) AS Maximum_Paid, Product, Category, Customers_City, Customers_State, Ordered_Date 
FROM product_sales 
GROUP BY Customers_City 
ORDER BY Maximum_Paid DESC;

-- How many rows?
SELECT count(*) FROM product_sales;

-- How many days are covered within this product_sales table? 
SELECT DATEDIFF(MAX(Ordered_Date),'2016-10-04 09:43:00') from product_sales;

-- Count number of distinct customers city
SELECT COUNT(DISTINCT(Customers_City)) FROM product_sales;

-- This code defines GetOrderByCity Stored Procedure
DROP PROCEDURE IF EXISTS GetOrderByCity;

DELIMITER //

CREATE PROCEDURE GetOrderByCity(
	IN cityName VARCHAR(255)
)
BEGIN
	SELECT * 
 		FROM product_sales
			WHERE Customers_City = cityName;
END //
DELIMITER ;

-- This Stored Procedure can be called by passing any city name 
-- Then this SP returns orders made by customers from that indicated city
CALL GetOrderByCity('sao paulo');


-- This code defines GetOrderAmountsByCity Stored Procedure
DROP PROCEDURE IF EXISTS GetOrderAmountsByCity;

DELIMITER $$

CREATE PROCEDURE GetOrderAmountsByCity (
	IN  cityName VARCHAR(25),
	OUT total INT
)
BEGIN
	SELECT COUNT(TransactionId)
	INTO total
	FROM product_sales
	WHERE Customers_City = cityName;
END$$
DELIMITER ;

SET @total = 0;
-- This Stored Procedure can be called by passing any city name and @total variable
-- Then this SP returns how many orders were made by customers from that indicated city 
-- and assigns this value to variable @total 
CALL GetOrderAmountsByCity('salvador', @total);
SELECT @total;
-- Number of orders made by customers from 'salvador' city: value of @total


-- This code defines GetPaidAmountByCity Stored Procedure
DROP PROCEDURE IF EXISTS GetPaidAmountByCity;

DELIMITER //

CREATE PROCEDURE GetPaidAmountByCity(
	IN cityName VARCHAR(255),
    OUT total INT
)
BEGIN
	SELECT sum(Paid_Amount) 
    INTO total 
    FROM product_sales 
    WHERE Customers_City = cityName;
END //
DELIMITER ;

-- This Stored Procedure can be called by passing any city name 
-- Then this SP returns SUM of Paid Amount for that indicated city
SET @total = 0;
CALL GetPaidAmountByCity('rio de janeiro', @total);
SELECT @total;