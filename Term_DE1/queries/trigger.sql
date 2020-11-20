USE db_malikov_a;

-- This table logs all triggers
CREATE TABLE log_orders (order_id VARCHAR(60) NULL, date_time DATETIME NULL);

-- This code defines trigger. Trigger works when new entry added to order_items table
DROP TRIGGER IF EXISTS after_insert_into_order; 

DELIMITER $$

CREATE TRIGGER after_insert_into_order
AFTER INSERT
ON order_items FOR EACH ROW
BEGIN
	
	-- log the order_id of the new inserted order
	INSERT INTO log_orders (order_id, date_time) SELECT CONCAT('new order_id: ', NEW.order_id), NOW();

	-- archive the order and assosiated table entries to product_sales
  	INSERT INTO product_sales
	SELECT 
	   order_items.order_id AS TransactionId, 
	   order_payments.payment_value AS Paid_Amount,
       products.product_id AS Product,
	   products.product_category_name AS Category,   
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
		customers USING (customer_id)
	ORDER BY 
		order_id, 
		order_item_id;
        
END $$

DELIMITER ;

-- INSERT INTO order_items VALUES('e1a3',1,'4244733e06e7ecb4970a6e2683c13e61','4a3ca9315b744ce9f8e9374361493884','2018-03-29 22:28:00',10,10);
-- INSERT INTO order_items VALUES('a3a3',1,'4244733e06e7ecb4970a6e2683c13e61','4a3ca9315b744ce9f8e9374361493884','2018-03-29 22:28:00',10,10);
-- INSERT INTO order_payments VALUES('a3a3', 1, 'credit_card', 1, 100);
-- INSERT INTO orders VALUES ('a3a3', '3ce436f183e68e07877b285a838db11a', 'delivered', '2017-09-13 08:59:00', '2017-09-13 09:45:00', '2017-09-29 00:00:00');
 