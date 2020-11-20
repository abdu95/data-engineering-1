SELECT * FROM db_malikov_a.product_sales;

-- SELECT * FROM db_malikov_a.product_sales where TransactionId = '00143d0f86d6fbd9f9b38ab440ac16f5' ;
SELECT DISTINCT Category FROM product_sales;
select * from product_sales where Paid_Amount > 100;
select * from product_sales where Category = 'cool_stuff';

DROP VIEW IF EXISTS perfume_products;

CREATE VIEW `perfume_products` AS
SELECT * FROM db_malikov_a.product_sales where Category = 'telephony';

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

SELECT 
   order_items.order_id AS TransactionId, 
   order_payments.payment_value AS Paid_Amount,
   products.product_id AS Product,
   product_category.product_category_name_english AS Category,   
   customers.customer_city AS Customers_City,
   customers.customer_state AS Customers_State,   
   orders.order_approved_at AS Ordered_Date,
   WEEK(orders.order_approved_at) AS WeekOfYear
FROM
	orders
INNER JOIN
	order_items USING (order_id)
INNER JOIN
	order_payments USING (order_id)
INNER JOIN
	products USING (product_id)
INNER JOIN 
	product_category USING (product_category_name)
INNER JOIN
	customers USING (customer_id);
