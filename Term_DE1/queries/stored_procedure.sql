USE db_malikov_a;

-- Below code defines and calls Stored Procedure named `create_product_sales`. 
-- This SP creates `product_sales` table for Analytical Layer
DROP PROCEDURE IF EXISTS create_product_sales;

DELIMITER //

CREATE PROCEDURE create_product_sales()
BEGIN

	DROP TABLE IF EXISTS product_sales;

	CREATE TABLE product_sales AS
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

END //
DELIMITER ;

CALL create_product_sales();