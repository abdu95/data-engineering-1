-- run sql from Lesson5 first
-- Exercise1
-- Join all fields of order and orderdetails
select * from orders;
select * from orderdetails;

SELECT * 
FROM orders 
INNER JOIN orderdetails   
ON orders.orderNumber = orderdetails.orderNumber;

-- Exercise2
-- Join all fields of order and orderdetails. 
-- Display only orderNumber, status and sum of totalsales (quantityOrdered * priceEach) for each orderNumber.
-- SUM(quantityOrdered * priceEach)
SELECT Ord.orderNumber, Ord.status, SUM(OrdD.quantityOrdered * OrdD.priceEach) totalSales 
FROM orders Ord 
INNER JOIN orderdetails OrdD  
ON Ord.orderNumber = OrdD.orderNumber GROUP BY Ord.orderNumber;

-- Exercise3
-- We want to how the employees are performing. 
-- Join orders, customers and employees and return orderDate, lastName, firstName
-- customers + employees = customers.salesRepEmployeeNumber
-- order + customer = orders.customerNumber
-- Now, do with alias
SELECT orders.orderDate, employees.lastName, employees.firstName
FROM orders
INNER JOIN customers
ON orders.customerNumber = customers.customerNumber
INNER JOIN employees 
ON customers.salesRepEmployeeNumber = employees.employeeNumber; 

-- teachers solution. no need to specify table name if column exists only in that table
SELECT orderDate, lastName, firstName
FROM orders t1 
INNER JOIN customers t2
ON t1.customerNumber = t2.customerNumber
INNER JOIN employees t3
ON t2.salesRepEmployeeNumber = t3.employeeNumber; 

-- no need to use AS for alias.
SELECT 
    CONCAT(m.lastName, ', ', m.firstName) AS Manager,
    CONCAT(e.lastName, ', ', e.firstName) AS 'Direct report'
FROM
    employees e
INNER JOIN employees m ON 
    m.employeeNumber = e.reportsTo
ORDER BY 
    Manager;
    
select * from employees;

-- Exercise4
-- Why President is not in the list? becuase ReportsTo Null

-- LEFT JOIN gets items from table2 even matching item not found, just shows NULL 
-- 350 rows returned
SELECT
    c.customerNumber,
    customerName,
    orderNumber,
    status
FROM
    customers c
LEFT JOIN orders o 
    ON c.customerNumber = o.customerNumber;
    
-- same query with INNER join
-- 326 rows returned
SELECT
    c.customerNumber,
    customerName,
    orderNumber,
    status
FROM
    customers c
INNER JOIN orders o 
    ON c.customerNumber = o.customerNumber;

-- WHERE with joins
SELECT 
    o.orderNumber, 
    customerNumber, 
    productCode
FROM
    orders o
LEFT JOIN orderDetails 
    USING (orderNumber)
WHERE
    orderNumber = 10123;
    
-- what is the meaning/differnce of this query?
SELECT 
    o.orderNumber, 
    customerNumber, 
    productCode
FROM
    orders o
LEFT JOIN orderDetails d 
    ON o.orderNumber = d.orderNumber AND 
       o.orderNumber = 10123;