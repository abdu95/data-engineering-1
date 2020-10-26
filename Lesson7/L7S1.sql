-- Exercise 2: birdstrikes2, id
USE birdstrikes;
CREATE TABLE birdstrikes2 LIKE birdstrikes;
INSERT INTO birdstrikes2 SELECT * from birdstrikes where id = 10;
select * from classicmodels.orderdetails;

use classicmodels;
select * from classicmodels.product_sales;

-- 2996 becomes 2997
select count(*) from classicmodels.product_sales;

DROP TRIGGER IF EXISTS after_order_insert; 

DELIMITER $$

CREATE TRIGGER after_order_insert
AFTER INSERT
ON orderdetails FOR EACH ROW
BEGIN
	
	-- log the order number of the newley inserted order
    	INSERT INTO messages SELECT CONCAT('new orderNumber: ', NEW.orderNumber);

	-- archive the order and assosiated table entries to product_sales
  	INSERT INTO product_sales
	SELECT 
	   orders.orderNumber AS SalesId, 
	   orderdetails.priceEach AS Price, 
	   orderdetails.quantityOrdered AS Unit,
	   products.productName AS Product,
	   products.productLine As Brand,
	   customers.city As City,
	   customers.country As Country,   
	   orders.orderDate AS Date,
	   WEEK(orders.orderDate) as WeekOfYear
	FROM
		orders
	INNER JOIN
		orderdetails USING (orderNumber)
	INNER JOIN
		products USING (productCode)
	INNER JOIN
		customers USING (customerNumber)
	WHERE orderNumber = NEW.orderNumber
	ORDER BY 
		orderNumber, 
		orderLineNumber;
        
END $$

DELIMITER ;

SELECT * FROM orders;

INSERT INTO orders  VALUES(16,'2020-10-01','2020-10-01','2020-10-01','Done','',131);
INSERT INTO orderdetails  VALUES(16,'S18_1749','1','10',1);

select * from messages;

select * from productlines;
select distinct productLine from productLines;

-- Create a data mart - View
-- 2 type of views
-- executed dynamically, when you are interested to open View
-- materialized view: updated time to time on memory

DROP VIEW IF EXISTS Vintage_Cars;
CREATE VIEW `Vintage_Cars` AS
SELECT * FROM product_sales WHERE product_sales.Brand = 'Vintage Cars';

select * from Vintage_Cars;

DROP VIEW IF EXISTS USA;

CREATE VIEW `USA` AS
SELECT * FROM product_sales WHERE country = 'USA';

select * from USA;

-- Exercise2: slicing based on time
-- Create a view, which contains product_sales rows of 2003 and 2005.

DROP VIEW IF EXISTS date_sales;

CREATE VIEW `date_sales` AS
SELECT * FROM product_sales WHERE YEAR(product_sales.Date) BETWEEN 2003 AND 2005; 

-- no records of 2005
select * from date_sales;
-- no records of 2005: mysql limiting results? I have too much rows?
select count(*) from product_sales;
select * from product_sales where SalesId = 10425;
select count(*) from date_sales;
-- record of 2005
select * from product_sales WHERE YEAR(product_sales.Date) = 2005; 
