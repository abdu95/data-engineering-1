## INTRODUCTION

This is the Term project that is done for Data Engineering 1 course by Malikov Abduvosid. 

This project consists of several steps including creating tables, extracting data, and building a data warehouse. 

## OPERATIONAL LAYER

First, a dataset was found that suits the project requirements. For this project, a Brazilian ecommerce public dataset was used that contains orders made at Olist Store. The dataset has information of 100k orders from 2016 to 2018 made at multiple marketplaces in Brazil. [Dataset link](https://www.kaggle.com/olistbr/brazilian-ecommerce?select=olist_order_items_dataset.csv)

Then, all these CSV files were downloaded to `dataset` folder. Relational database with corresponding tables were created based on these CSV files in MySQL. This is the operational data layer of the project. 

## ETL PIPELINE
An ETL pipeline was built using `create_product_sales` Stored Procedure (`stored_procedure.sql`) and `after_insert_into_order` Trigger (`trigger.sql`). 

`E` - Extract: as an extract operation of operational layer, the following tables were joined together within `create_product_sales` Stored Procedure: order_items, order_payments, products, customers, orders.

`T` - Transform: WeekOfYear column made with `create_product_sales` Stored Procedure transforms the orderDate column into the week of the year format. Also, in Analytic queries, Paid Amount was divided into different categories (LOW, HIGH) and other colum aggregations were done.

`L` - Load: This Stored Procedure loads extracted data into the product_sales table. Also, loading CSV files into the corresponding tables also the part of Load operation

`after_insert_into_order` Trigger works when new row inserted into order_items table (because of TransactionId)

The database diagram is shown in `diagram.pdf` and `db_diagram.png` files

## ANALYTICS PLAN

Business owners may be interested in different analytical questions. Here are the pontential analytical questions that may be asked:

- Order with highest paid amount
- What was the cost of the order with highest paid amount?
- Top 100 Orders with the highest paid amount
- Select customer cities starting with 'A'
- From which cities the orders were made with Paid Amount higher than 5000?
- From which cities the baby products with Paid Amount higher than 2000 were ordered?
- Show all orders made between 2016 and 2018
- Show orders by dividing them into 3 price categories: 'NO PRICE', 'MEDIUM PRICE', 'HIGH PRICE'
- What is the sum of all Paid Amounts of all orders?
- What is the average (mean) of Paid Amount of all orders?
- Orders with maximum Paid Amount grouped by cities and ordered by Paid Amount in descending order
- How many days are covered within this table?
- How many states are covered within this table?
- Show each order made from a given city
- Show how many orders were made from a given city


## ANALYTICAL LAYER 

`product_sales` table serves for analytical purposes. This table consists of Fact and Dimensions.
- Sales Fact - TransactionId (order_id)
Dimensions: 
- Product Dimension: Product ID and Product Category
- Market Dimension: Customer's City and Customer's State
- Date Dimension: Ordered Date and Week of Year of that order.

The questions that were listed in ANALYTICS PLAN section were answered using this table and using queries written in `analytics.sql` file. 


## DATA MART
`data_mart.sql` file contains queries that creates Views which functions as Data Marts.

- VIEW `perfume_products`: slicing based on category. View when product from 'perfumaria' category was ordered
- VIEW `rio_sales`: slicing based on region. View when order was made by the customer whose city was 'rio de janeiro'
- VIEW `sales_2017`: slicing based on time: View for all orders made in the year of 2017


## REPRODUCE 
It is recommended to use CSV files in `dataset` folder (not original dataset from website). The original dataset contained quotes in some columns and therefore original dataset of CSV files were modified slightly in order to smoothly work with MySQL commands.

Order of execution of sql queries and their purpose:

1. `create_tables.sql` - creates tables and loads data from CSV files to these tables. Operational Layer
2. `stored_procedure.sql` - defines and calls Stored Procedure named `create_product_sales`. This SP creates `product_sales` table for Analytical Layer
3. `data_mart.sql` - creates Views that functions as a Data Mart for a BI operations such as reporting.
4. `trigger.sql` - creates trigger
5. `analytics.sql` - contains queries for analytical purposes


### SQL Settings:

#### Timeout 
Some tables contain a lot of data (100000 rows). Therefore, timeout change in MySQL Workbench Settings maybe required to execute the SQL Query to load csv for olist_order_items table. It is shown in picture SQL_timeout_settings.png 

#### Safe Mode
While updating a table product_category, the following Error was encountered: 
Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  
Therefore, to disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect. It is shown in picture SQL_safe_update.png