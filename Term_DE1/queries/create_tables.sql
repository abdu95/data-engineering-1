-- Check if database exists
DROP SCHEMA IF EXISTS db_malikov_a;

-- Create a database (schema) named 'db_malikov_a'
CREATE SCHEMA db_malikov_a;

-- Use this database
USE db_malikov_a;

SHOW VARIABLES LIKE "secure_file_priv";
-- 'C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\'

DROP TABLE IF EXISTS customers;

-- creating Customers table  
CREATE TABLE customers (
	customer_id VARCHAR(60) NOT NULL,
	customer_unique_id VARCHAR(50) NOT NULL,	
    customer_zip_code_prefix INT NOT NULL,	
    customer_city VARCHAR(50) NOT NULL,
    customer_state VARCHAR(50) NOT NULL,
    PRIMARY KEY (customer_id)
    ) ENGINE = InnoDB DEFAULT CHARSET = UTF8MB4;

-- loading CSV file into Customers table
LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_customers_dataset.csv' 
INTO TABLE customers 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(customer_id, customer_unique_id, customer_zip_code_prefix, customer_city, customer_state);

DROP TABLE IF EXISTS products;

-- creating Products table  
CREATE TABLE products (
	product_id VARCHAR(60) NOT NULL,
    product_category_name VARCHAR(50) NOT NULL,	
    product_name_length INT NULL,
    product_description_length INT NULL,
    product_photos_qty INT NULL,
    product_weight_g INT NULL,
    product_length_cm INT NULL,
    product_height_cm INT NULL,
    product_width_cm INT NULL,
    PRIMARY KEY (product_id)
) ENGINE = InnoDB DEFAULT CHARSET = UTF8MB4;

-- loading CSV file into Products table
LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_products_dataset.csv' 
INTO TABLE products 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(product_id, product_category_name, @v_product_name_length, @v_product_description_length, @v_product_photos_qty, @v_product_weight_g, @v_product_length_cm, @v_product_height_cm, @v_product_width_cm)
SET 
product_name_length = nullif(@v_product_name_length, ''),
product_description_length = nullif(@v_product_description_length, ''),
product_photos_qty = nullif(@v_product_photos_qty, ''),
product_weight_g = nullif(@v_product_weight_g, ''),
product_length_cm = nullif(@v_product_length_cm, ''),
product_height_cm = nullif(@v_product_height_cm, ''),
product_width_cm = nullif(@v_product_width_cm, '');

DROP TABLE IF EXISTS sellers;

-- creating Sellers table  
CREATE TABLE sellers (
	seller_id VARCHAR(50) NOT NULL,
    seller_zip_code_prefix INT NOT NULL,
    seller_city VARCHAR(50) NOT NULL,
    seller_state VARCHAR(50) NOT NULL,
	PRIMARY KEY (seller_id)
) ENGINE = InnoDB DEFAULT CHARSET = UTF8MB4;

-- loading CSV file into Sellers table
LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_sellers_dataset.csv' 
INTO TABLE sellers 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(seller_id, seller_zip_code_prefix, seller_city, seller_state);

DROP TABLE IF EXISTS order_items;

-- creating OrderItems table 
CREATE TABLE order_items (
	order_id VARCHAR(50) NOT NULL,
    order_item_id INT NOT NULL,
    product_id VARCHAR(60) NOT NULL,
    seller_id VARCHAR(50) NOT NULL,
    shipping_limit_date DATETIME NOT NULL,
    price DECIMAL(6,2) NOT NULL,
    freight_value DECIMAL(6,2) NOT NULL,
    PRIMARY KEY (order_id),
    KEY product_id (product_id),
	KEY seller_id (seller_id),
	CONSTRAINT order_items_ibfk_1 FOREIGN KEY (product_id) REFERENCES products (product_id),
    CONSTRAINT order_items_ibfk_2 FOREIGN KEY (seller_id) REFERENCES sellers (seller_id)
) ENGINE = InnoDB DEFAULT CHARSET = UTF8MB4;

-- loading CSV file into OrderItems table
LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_items_dataset.csv' 
INTO TABLE order_items 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(order_id, order_item_id, product_id, seller_id, @v_shipping_limit_date, price, freight_value)
SET 
shipping_limit_date = STR_TO_DATE(@v_shipping_limit_date, '%m/%d/%Y %H:%i');

DROP TABLE IF EXISTS order_payments;

-- creating OrderPayments table 
CREATE TABLE order_payments (
	order_id VARCHAR(50) NOT NULL,
    payment_sequential INT NOT NULL,
    payment_type VARCHAR(50) NOT NULL,
    payment_installments INT NOT NULL,
    payment_value DECIMAL(7,2) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = UTF8MB4;

-- loading CSV file into OrderPayments table
LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_payments_dataset.csv' 
INTO TABLE order_payments 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(order_id, payment_sequential, payment_type, payment_installments, payment_value);

DROP TABLE IF EXISTS orders;

-- creating Orders table 
CREATE TABLE orders (
	order_id VARCHAR(50) NOT NULL,
    customer_id VARCHAR(60) NULL,
    order_status VARCHAR(50) NOT NULL,
    order_purchase_timestamp DATETIME NOT NULL,
    order_approved_at DATETIME NOT NULL,
    order_estimated_delivery_date DATETIME NOT NULL,
	PRIMARY KEY (order_id),
    KEY customer_id (customer_id),
    CONSTRAINT orders_ibfk_1 FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
) ENGINE = InnoDB DEFAULT CHARSET = UTF8MB4;

-- loading CSV file into Orders table
LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_orders_dataset.csv' 
INTO TABLE orders
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(order_id, customer_id, order_status, @v_order_purchase_timestamp, @v_order_approved_at, @v_order_estimated_delivery_date)
SET 
order_purchase_timestamp = STR_TO_DATE(@v_order_purchase_timestamp, '%m/%d/%Y %H:%i'),
order_approved_at = STR_TO_DATE(@v_order_approved_at, '%m/%d/%Y %H:%i'),
order_estimated_delivery_date = STR_TO_DATE(@v_order_estimated_delivery_date, '%m/%d/%Y %H:%i');


DROP TABLE IF EXISTS product_category;

-- creating ProductCategory table 
CREATE TABLE product_category (
	product_category_name VARCHAR(60) NULL,
    product_category_name_english VARCHAR(60) NULL
)  ENGINE = InnoDB DEFAULT CHARSET = UTF8MB4;


-- loading CSV file into ProductCategory table
LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/product_category_name.csv' 
INTO TABLE product_category
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(product_category_name, product_category_name_english);