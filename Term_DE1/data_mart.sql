SELECT * FROM db_malikov_a.product_sales;

-- SELECT * FROM db_malikov_a.product_sales where TransactionId = '00143d0f86d6fbd9f9b38ab440ac16f5' ;

DROP VIEW IF EXISTS Perfume_Products;

CREATE VIEW `Perfume_Products` AS
SELECT * FROM db_malikov_a.product_sales where Category = 'perfumaria';

DROP VIEW IF EXISTS Rio_Sales;

CREATE VIEW `Rio_Sales` AS
SELECT * FROM db_malikov_a.product_sales where Customers_City = 'rio de janeiro';

-- To which category belongs the sales with the highest Paid_Amount?
-- From which Customers_City the highest sales are made? Which city is mentioned most? and least?
-- Which Product sold most? Which product brought highest sales?
-- Which Customer bought most items? Which customer made most expensive purchases?
-- In which day the highest amount of sales made? (Which days mentioned most frequently?)
-- Which weeks had highest sales?

SELECT product_category_name_english 
FROM products 
INNER JOIN product_category  
ON products.product_category_name = product_category.product_category_name;


