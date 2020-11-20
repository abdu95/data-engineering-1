SELECT * FROM db_malikov_a.product_sales where Product = '4244733e06e7ecb4970a6e2683c13e61';

-- Order with highest paid amount
SELECT * FROM product_sales ORDER BY Paid_Amount DESC LIMIT 1;

-- Top 100 Order with the highest paid amount
SELECT * FROM product_sales ORDER BY Paid_Amount DESC LIMIT 100;


-- Exercise2: slicing based on time
-- Create a view, which contains product_sales rows of 2003 and 2005.

DROP VIEW IF EXISTS date_sales;

CREATE VIEW `date_sales` AS
SELECT * FROM product_sales WHERE YEAR(product_sales.Date) BETWEEN 2003 AND 2005; 

-- how many rows?
SELECT count(*) FROM product_sales;

-- How many observation days we have in product_sales
SELECT DATEDIFF(MAX(Ordered_Date),'2016-10-04 09:43:00') from product_sales;
SELECT (MAX(Ordered_Date)) FROM product_sales;
SELECT (MIN(Ordered_Date)) FROM product_sales;
SELECT * FROM product_sales ORDER BY Ordered_Date ASC LIMIT 100;
SELECT * FROM product_sales WHERE YEAR(product_sales.Ordered_Date) BETWEEN 2016 AND 2018 ORDER BY Ordered_Date; 

