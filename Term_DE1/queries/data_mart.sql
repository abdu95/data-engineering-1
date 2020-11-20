USE db_malikov_a;

-- Views

-- Slicing based on category: 
-- View when product from 'perfumaria' category was ordered
DROP VIEW IF EXISTS perfume_products;

CREATE VIEW `perfume_products` AS
SELECT * FROM db_malikov_a.product_sales WHERE Category = 'perfumaria';


-- Slicing based on region: 
-- View when order was made by the customer whose city was 'rio de janeiro'
DROP VIEW IF EXISTS Rio_Sales;

CREATE VIEW `rio_sales` AS
SELECT * FROM db_malikov_a.product_sales where Customers_City = 'rio de janeiro';


-- Slicing based on time: 
-- View for all orders made in the year of 2017
DROP VIEW IF EXISTS sales_2017;

CREATE VIEW `sales_2017` AS
SELECT * FROM db_malikov_a.product_sales WHERE YEAR(Ordered_Date) = 2017;