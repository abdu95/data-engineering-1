- orders.orderNumber AS SalesId - orders.orderId
- orderdetails.priceEach AS Price - order_payments.payment_value
- _orderdetails.quantityOrdered AS Unit_ 
- products.productName AS Product - products.product_id
- products.productLine As Brand - products.product_category_name
- customers.city As City - customers.customer_city
- customers.country As Country - customers.customer_state
- orders.orderDate AS Date - orders.order_approved_at


Creating the analytical data store
We will use a query created in Homework 3. This creates a denormalized snapshot of the operational tables for product_sales subject. We will embed the creation in a stored procedure.

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

## Things to do later

1. Remove " " from 2 columns in customers
2. Cast customer table zip_code column to integer
I tried this [https://stackoverflow.com/questions/13741959/trying-to-import-csv-file-with-load-data-local-file-sql-and-cast-as-integer]


Laslo's hint:
nope
    ENCLOSED BY '"'
    ESCAPED BY '"' 

yes

remove quotes from CSV using bash command:
    awk '{gsub(/\"/,"")};1' input.csv > output.csv



Two columns of sellers table and "nove hamburgo" was with quotes. I opened CSV in Excel, removed commas from  "nove hamburgo" and quotes from two columns and from "nove hamburgo" was removed. 

In customers, write code that removes quotes from everywhere. Then, try to Load. Load will show you error that shows in which row there is extra comma.

9 CSV
3 done
geo & category - not sure. 

- order items - includes product_id and seller_id
- order_payments - takes order_id from orders. (do I need this table? for payment?) This table is similar to orderdetails table in Class Example


Before writing Constraint for FK, I shoud write KEY above it?
Only in one situation KEY is not used above. This is where this is column itself is already PRIMARY **KEY**.


FK didnt work. Changing charset helps? Yes

1, 3, 4 columns ("order_id", "product_id","seller_id",) are in quotation. 

Incorrect datetime value: '9/19/2017 9:45' for function str_to_date

    SET shipping_limit_date = STR_TO_DATE(@v_shipping_limit_date, '%m/%d/%Y %H:%i');

Duplicate entry '00143d0f86d6fbd9f9b38ab440ac16f5' for key 'order_items.PRIMARY'
2 duplicates

Error Code: 1062. Duplicate entry '0008288aa423d2a3f00fcb17cd7d8719' for key 'order_items.PRIMARY'
3 duplicates
Error Code: 1062. Duplicate entry '001ab0a7578dd66cd4b0a71f5b6e1e41' for key 'order_items.PRIMARY'


- How to find duplicates in order_id?
- Iterate over each row in csv (112648 lines), compare the current value with previous value, if they are same, add to list. Then print this list: it will contain all duplicates


Remove duplicate keys
112648 lines
if i < 112648

    for page in {2..112648}
    do
            if [$page cat olist_order_items_dataset.csv | cut -d ',' -f1 | head -11]
    done

https://www.somacon.com/p568.php shows how many duplicates exist
*how to remove duplicates in csv*
https://support.shippingeasy.com/hc/en-us/articles/204095315-How-to-Check-CSV-uploads-for-duplicates-and-delete-them
Good idea but it will take weeks to delete duplicate rows mannually

https://www.geeksforgeeks.org/python-pandas-dataframe-drop_duplicates/ Good idea but its working only with columns


https://docs.google.com/spreadsheets/d/1BpGoa1xFpWAqvowAf5QGdYEkCZfs-B47oVsN_zM3OhQ/edit#gid=0


    SHOW ENGINE INNODB STATUS;
shows lock unlock thread and some other unknown outputs related to MySQL inner work. 

Error Code: 1366. Incorrect integer value: '' for column 'order_item_id' at row 98667

Excel >> selec rows from 98666 until 12648 >> delete >> Entire row >> Save

-- current directory
select @@datadir;

WARNING! 
Timeout change maybe required to execute the SQL Query to load csv for olist_order_items table. 


Error Code: 1264. Out of range value for column 'payment_value' at row 52108
Therefore, 
    payment_value DECIMAL(7,2) NOT NULL

is used for table order_payments

> order_payments table was created without PK. Why? Becuase csv contains duplicates. Is it necessary for this table to have PK? Is join with FK possible even without PK?

Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`db_malikov_a`.`orders`, CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`))

The reason is in quotations? I think yes. after removing quotes with awk, new Error appeared. 

Error Code: 1292. Incorrect datetime value: '' for column 'order_delivered_carrier_date' at row 7


1. Quantity 
2. Analytics plan
3. Data Mart
4. Category English
5. Ensure that you copy CSV files from Uploads to dataset folder. After finishing the project, check your queries are getting CSV files from appropriate folder, tables are populated and queries are working without Errors

Quantity and Price giving Fact table. Fact table gives revenue: price*quantity
What is your Fact table doing?