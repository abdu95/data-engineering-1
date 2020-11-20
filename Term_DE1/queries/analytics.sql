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
SELECT AVG(Paid_Amount) FROM product_sales;
-- Answer: 153.76

-- Orders with maximum Paid Amount grouped by cities and ordered by Paid Amount in descending order
SELECT TransactionId, MAX(Paid_Amount) AS Maximum_Paid, Product, Category, Customers_City, Customers_State, Ordered_Date 
FROM product_sales 
GROUP BY Customers_City 
ORDER BY Maximum_Paid DESC;

-- how many rows?
SELECT count(*) FROM product_sales;

-- How many observation days we have in product_sales
SELECT DATEDIFF(MAX(Ordered_Date),'2016-10-04 09:43:00') from product_sales;


SELECT (MAX(Ordered_Date)) FROM product_sales;
SELECT (MIN(Ordered_Date)) FROM product_sales;
SELECT * FROM product_sales ORDER BY Ordered_Date ASC LIMIT 100;

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


-- ROUND, SQRT
SELECT ROUND(SQRT(speed/2) * 10) AS synthetic_speed FROM birdstrikes;


-- Count number of distinct states
SELECT COUNT(DISTINCT(state)) FROM birdstrikes;




