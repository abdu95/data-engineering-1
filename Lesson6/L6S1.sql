use classicmodels;
DROP PROCEDURE IF EXISTS LoopDemo;

DELIMITER $$
CREATE PROCEDURE LoopDemo()
BEGIN
	        
	myloop: LOOP
    select * from offices;
			LEAVE myloop;      
	END LOOP myloop;
END$$
DELIMITER ;

call LoopDemo();

-- exercise

DROP PROCEDURE IF EXISTS CountLoop;

DELIMITER $$
CREATE PROCEDURE CountLoop()
BEGIN
DECLARE x  INT;
    
	SET x = 0;
        
	myloop: LOOP 
	           
		SET  x = x + 1;
    		SELECT x;
           
		IF  (x = 5) THEN
			LEAVE myloop;
         	END  IF;
         
	END LOOP myloop;
END$$
DELIMITER ;

-- SELECT X --> means display X
call CountLoop();

-- in stored procedure, we cannot do debugging. so instead, lets create a table and log the value of var to that table
CREATE TABLE IF NOT EXISTS messages (message varchar(100) NOT NULL);

DROP PROCEDURE IF EXISTS CountLoopMessages;

DELIMITER $$
CREATE PROCEDURE CountLoopMessages()
BEGIN
    DECLARE x INT;
	SET x = 0;
	TRUNCATE messages;
    myloop: LOOP
		SET x = x + 1;
			INSERT INTO messages SELECT CONCAT('x:',x);
		IF (x = 5) THEN LEAVE myloop;
		END IF;
	END LOOP myloop;
END$$
DELIMITER ;

CALL CountLoopMessages();
SELECT * FROM messages;

CREATE TABLE IF NOT EXISTS phoneNumbers (message varchar(100) NOT NULL);

drop procedure if exists CursorDemo;

DELIMITER $$
create procedure CursorDemo()
BEGIN
	declare phone varchar(50) default 'x';
    declare finished integer default 0;
    declare curPhone cursor for select customers.phone from classicmodels.customers;
    declare continue handler for not found set finished = 1;
    open curPhone;
    truncate phoneNumbers;
    myloop: LOOP
		FETCH curPhone INTO phone;
        INSERT INTO phoneNumbers SELECT CONCAT('phone:', phone);
        IF finished = 1 THEN LEAVE myloop;
        END IF;
	END LOOP myloop;
END$$

DELIMITER ;

call CursorDemo();

select * from phoneNumbers;

create table new_order like orders;
drop table new_order;
create table new_order as select * from orders;

-- product_sales

create procedure createProductSales()
begin 
	drop table if exists product_sales;
    create table product_sales as 
    select 

select * from classicmodels.product_sales;
-- This is ETL without T: EL

DROP PROCEDURE IF EXISTS CreateProductSalesStore;

DELIMITER //

CREATE PROCEDURE CreateProductSalesStore()
BEGIN

	DROP TABLE IF EXISTS product_sales;

	CREATE TABLE product_sales AS
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
	ORDER BY 
		orderNumber, 
		orderLineNumber;

END //
DELIMITER ;


CALL CreateProductSalesStore();


-- but what if previous table changes?
-- should we do EL all the time, manually?
-- option 1: schedule
-- option 2: condition that checks whether there is a change in previous table,
-- if there is a change, do EL

-- events. system variable = 
SHOW VARIABLES LIKE "event_scheduler";

-- on
SET GLOBAL event_scheduler = ON;
SET GLOBAL event_scheduler = OFF;
show events;
truncate messages;

-- it is valid within 1 hour, it is executed every minute
-- logging the execution of event: NOW()

DELIMITER $$

CREATE EVENT CreateProductSalesStoreEvent
ON SCHEDULE EVERY 1 MINUTE
STARTS CURRENT_TIMESTAMP
ENDS CURRENT_TIMESTAMP + INTERVAL 1 HOUR
DO
	BEGIN
		INSERT INTO messages SELECT CONCAT('event:',NOW());
    		CALL CreateProductSalesStore();
	END$$
DELIMITER ;


SHOW EVENTS;

-- stop event: drop or turn it off
select * from messages;

-- if you turn it off for more than 1 hour, and execute again, it will not work. because you set interval to 1 hour