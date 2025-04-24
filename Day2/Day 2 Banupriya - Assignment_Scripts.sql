
---------------------Day 2 - SQL Scripts - Banupriya:
------1)      Alter Table:
--Add a new column linkedin_profile to employees table to store LinkedIn URLs as varchar.
ALTER TABLE employees add column linkedin_profile varchar(100);
--Change the linkedin_profile column data type from VARCHAR to TEXT.
ALTER TABLE employees alter column linkedin_profile type text;
--Need to update the null values with unique values to make the column as Not Null and Unique.
UPDATE employees set linkedin_profile = 'https://linkedin.com/placeholder-' || "employeeID"  where linkedin_profile is NULL;
--Adding Not Null Constraint
ALTER TABLE employees alter column linkedin_profile set NOT NULL; 
--Adding Unique Constraint
ALTER TABLE employees ADD CONSTRAINT unique_linked UNIQUE (linkedin_profile);
--Dropping the column
ALTER TABLE employees drop column linkedin_profile;

Select * from employees;

------2)      Querying (Select)
--Retrieve the employee name and title of all employees
SELECT "employeeName",title from employees;
--Retrieve the first name, last name, and title of all employees
SELECT SPLIT_PART("employeeName",' ',1) as first_name,SPLIT_PART("employeeName",' ',2) as last_name, title from employees; 
--Find all unique unit prices of products
SELECT DISTINCT unitprice FROM products ORDER BY unitprice;
--List all customers sorted by company name in ascending order
SELECT * FROM customers ORDER BY "companyName"
--Display product name and unit price, but rename the unit_price column as price_in_usd
select productname,unitprice as price_in_usd from products;

--------3)      Filtering
--Get all customers from Germany.
select * from customers where country = 'Germany';
--Find all customers from France or Spain
select * from customers where country in ('France','Spain') ORDER BY country;
--Retrieve all orders placed in 2014(based on order_date), and either have freight greater than 50 or the shipped date available (i.e., non-NULL)  (Hint: EXTRACT(YEAR FROM order_date))
SELECT *, 
       EXTRACT(YEAR FROM orderdate) AS ordered_year
FROM orders
WHERE (freight > 50 OR shippeddate IS NOT NULL)
  AND EXTRACT(YEAR FROM orderdate) = 2014;

  
-------4)      Filtering
--Retrieve the product_id, product_name, and unit_price of products where the unit_price is greater than 15.
select "productID",productname,unitprice from products where unitprice > 15 order by unitprice;
--List all employees who are located in the USA and have the title "Sales Representative".
select * from employees where country = 'USA' and title = 'Sales Representative';
--Retrieve all products that are not discontinued and priced greater than 30.
select * from products where discontinued = 'false' and unitprice > 30 order by unitprice;

-------5)      LIMIT/FETCH
--Retrieve the first 10 orders from the orders table.
select * from orders LIMIT 10;
--Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20).
select * from orders LIMIT 10 OFFSET 10;

------6)      Filtering (IN, BETWEEN)
--List all customers who are either Sales Representative, Owner
select * from customers where "contactTitle" in ('Sales Representative','Owner');
--Retrieve orders placed between January 1, 2013, and December 31, 2013.
select * from orders where orderdate between '2013-01-01' and '2013-12-31' order by orderdate;

-----7)      Filtering
--List all products whose category_id is not 1, 2, or 3.
select * from products where "categoryID" not in (1,2,3) order by "categoryID";
--Find customers whose company name starts with "A".
select * from customers where "companyName" like 'A%';

-----8)       INSERT into orders table:
/*Task: Add a new order to the orders table with the following details:
Order ID: 11078
Customer ID: ALFKI
Employee ID: 5
Order Date: 2025-04-23
Required Date: 2025-04-30
Shipped Date: 2025-04-25
shipperID:2
Freight: 45.50*/

insert into orders("orderID","customerID","employeeID",orderdate,requireddate,shippeddate,"shipperID",freight)
values (11078,'ALFKI',5,'2025-04-23','2025-04-30','2025-04-25',2,45.50);

select * from orders where "orderID" = 11078;
 
--9)      Increase(Update)  the unit price of all products in category_id =2 by 10%.(HINT: unit_price =unit_price * 1.10)
select * from products where "categoryID" = 2
Update products set unitprice = unitprice * 1.10 where "categoryID" = 2;
UPDATE products
SET unitprice = ROUND(unitprice::numeric, 2);
 
/*10) Sample Northwind database:
Download
 Download northwind.sql from below link into your local. Sign in to Git first https://github.com/pthom/northwind_psql
 Manually Create the database using pgAdmin:
 Right-click on "Databases" → Create → Database
Give name as ‘northwind’ (all small letters)
Click ‘Save’

Import database:
 Open pgAdmin and connect to your server          	
  Select the database  ‘northwind’
  Right Click-> Query tool.
  Click the folder icon to open your northwind.sql file
 Press F5 or click the Execute button.
  You will see total 14 tables loaded
  Databases → your database → Schemas → public → Tables*/

--Script: Ran the scripts from the northwind.sql file and attached the screenshot of the db with the 14 tables on to the word document.
