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


-- how many rows?
SELECT count(*) FROM product_sales;

-- How many observation days we have in product_sales
SELECT DATEDIFF(MAX(Ordered_Date),'2016-10-04 09:43:00') from product_sales;
SELECT (MAX(Ordered_Date)) FROM product_sales;
SELECT (MIN(Ordered_Date)) FROM product_sales;
SELECT * FROM product_sales ORDER BY Ordered_Date ASC LIMIT 100;
SELECT * FROM product_sales WHERE YEAR(product_sales.Ordered_Date) BETWEEN 2016 AND 2018 ORDER BY Ordered_Date; 

SELECT DISTINCT Category FROM product_sales;
select * from product_sales where Paid_Amount > 100;


-- To which category belongs the sales with the highest Paid_Amount?
-- From which Customers_City the highest sales are made? Which city is mentioned most? and least?
-- Which Product sold most? Which product brought highest sales?
-- Which Customer bought most items? Which customer made most expensive purchases?
-- In which day the highest amount of sales made? (Which days mentioned most frequently?)
-- Which weeks had highest sales?

SELECT * FROM product_sales;
SELECT DISTINCT Customers_City, Category FROM product_sales;


SELECT * FROM product_sales WHERE Paid_Amount > 1000 AND Category = 'bebes';




