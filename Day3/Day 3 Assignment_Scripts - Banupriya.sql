---------------------Day 3 - SQL Scripts: Banupriya

--1)      Update the categoryName From “Beverages” to "Drinks" in the categories table.
select * from categories order by "categoryID";
Update categories set "categoryName" = 'Drinks' where "categoryID" = 1;

--2)      Insert into shipper new record (give any values) Delete that new record from shippers table.
select * from shippers
insert into shippers ("shipperID","companyName") VALUES (4,'Sample Company');
Delete from shippers where "shipperID" = 4;

/*3)      Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. Display the both category and products table to show the cascade.
 Delete the categoryID= “3”  from categories. Verify that the corresponding records are deleted automatically from products.
 (HINT: Alter the foreign key on products(categoryID) to add ON UPDATE CASCADE, ON DELETE CASCADE, add ON DELETE CASCADE for order_details(productid) )*/

--Dropping the constraints and recreating them for cascading:
ALTER TABLE products DROP CONSTRAINT product_categoryid_fkey;
ALTER TABLE products ADD CONSTRAINT product_categoryid_fkey FOREIGN KEY ("categoryID")
        REFERENCES public.categories ("categoryID")
		ON UPDATE CASCADE 
		ON DELETE CASCADE; 

ALTER TABLE orderdetails DROP CONSTRAINT orderdetails_productid_fkey;
ALTER TABLE orderdetails ADD CONSTRAINT orderdetails_productid_fkey FOREIGN KEY ("productID")
        REFERENCES public.products ("productID")
		ON UPDATE CASCADE 
		ON DELETE CASCADE; 

select * from categories order by 1 desc;
UPDATE categories set "categoryID" = 1001 where "categoryID" = 1;
select * from products where "categoryID" = 3 order by "categoryID" desc
select * from orderdetails where "productID" in (16,19,20,21,25,26,27,47,48,49,50,62,68)
DELETE from categories where "categoryID" = 3;

--4)      Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to null (HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL)

--Dropping the constraints and recreating them for cascading:
ALTER TABLE orders DROP CONSTRAINT order_customerid_fkey;
ALTER TABLE orders ADD CONSTRAINT order_customerid_fkey FOREIGN KEY ("customerID")
        REFERENCES public.customers ("customerID")
		ON DELETE SET NULL;

select * from customers where "customerID" = 'VINET';
select * from orders where "customerID" = NULL;
select * from orderdetails where "orderID" in (10248,10274,10295,10737,10739);
DELETE FROM customers where "customerID" = 'VINET';

/*5)      Insert the following data to Products using UPSERT:
product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=5
product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=5
product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=5
(this should update the quantityperunit for product_id = 100)*/

--Regular Inserts are happening

INSERT into products("productID","productname",quantityperunit,unitprice,discontinued,"categoryID")
VALUES (100,'Wheat bread',1,13,false,5),
(101,'Wheat bread',5,13,false,5)
ON CONFLICT ("productID")
DO UPDATE
SET quantityperunit = 10;

--Upsert is happening based on the conflict.

INSERT into products("productID","productname",quantityperunit,unitprice,discontinued,"categoryID")
VALUES (100,'Wheat bread',10,13,false,5)
ON CONFLICT ("productID")
DO UPDATE
SET quantityperunit = EXCLUDED.quantityperunit;

select * from products where "productID" = 100

/*6)      Write a MERGE query:
Create temp table with name:  ‘updated_products’ and insert values as below:
 
productID	productName	quantityPerUnit	unitPrice	discontinued	categoryID
                     	100	Wheat bread	10	20	1	5
101	White bread	5 boxes	19.99	0	5
102	Midnight Mango Fizz	24 - 12 oz bottles	19	0	1
103	Savory Fire Sauce	12 - 550 ml bottles	10	0	2
 
•	 Update the price and discontinued status for from below table ‘updated_products’ only if there are matching products and updated_products .discontinued =0 
•	If there are matching products and updated_products .discontinued =1 then delete  
•	 Insert any new products from updated_products that don’t exist in products only if updated_products .discontinued =0.*/

-- Creating the temp table updated_products and inserting the values:

create temp table updated_products(productid int,productname varchar(100),quantityperunit varchar(100),unitprice real,discontinued boolean,categoryid smallint);

insert into updated_products
values (100,'wheat bread',10,20,'true',5),
(101,'wheat bread','5boxes',19.99,'false',5),
(102,'Midnight Mango Fizz','24 - 12 oz bottles',19,'false',1001),
(103,'Savory Fire Sauce','12 - 550 ml bottles',10,'false',2);

select * from updated_products

-- Merge Query:

MERGE INTO products pr
USING updated_products up
ON pr."productID" = up.productid
WHEN MATCHED AND up.discontinued = 'false' THEN
	UPDATE SET
		unitprice = up.unitprice,
		discontinued = up.discontinued
WHEN MATCHED AND up.discontinued = 'true' THEN
	DELETE
WHEN NOT MATCHED AND up.discontinued = 'false' THEN
	INSERT ("productID",productname,quantityperunit,unitprice,discontinued,"categoryID")
	VALUES (up.productid,up.productname,up.quantityperunit,up.unitprice,up.discontinued,up.categoryid);

select * from products where "productID" in (101,102,103)

--USE NEW Northwind DB:
--7)      List all orders with employee full names. (Inner join)

select o.order_id,e.employee_id,e.first_name || ' ' || e.last_name as FullNames from orders o,employees e where e.employee_id = o.employee_id;
