1.
update categories
set categoryName='drinks'
where categoryName='beverages';
2.
insert into shippers(shipperID,companyName)
values(4,'DML');
select * from shippers;
delete from shippers
where shipperID=4 AND companyName='DML';
select * from shippers;
3.
SELECT * FROM categories
WHERE categoryid = 1;
ALTER TABLE products
DROP CONSTRAINT IF EXISTS products_categoryid_fkey;
ALTER TABLE products
Add CONSTRAINT products_categoryid_fkey
FOREIGN KEY (categoryid) REFERENCES categories(categoryid)
ON UPDATE CASCADE;
UPDATE categories
SET categoryid = 1001
WHERE categoryid = 1;
SELECT * FROM categories
WHERE categoryid = 1001;
SELECT * FROM products
WHERE categoryid = 1001;
SELECT * FROM categories
WHERE categoryid = 3;
ALTER TABLE products
DROP CONSTRAINT IF EXISTS products_categoryid_fkey;
ALTER TABLE order_details
DROP CONSTRAINT IF EXISTS order_details_productid_fkey;
ALTER TABLE products
Add CONSTRAINT products_categoryid_fkey
FOREIGN KEY (categoryid) REFERENCES categories(categoryid)
ON DELETE CASCADE;
DELETE FROM categories
WHERE categoryid = 3;
SELECT * FROM categories WHERE categoryid = 3;
SELECT * FROM products WHERE categoryid = 3;
4.
 SELECT * FROM customers
 WHERE customerid = 'VINET';
ALTER TABLE orders
DROP CONSTRAINT IF EXISTS orders_customerid_fkey;
ALTER TABLE orders
ADD CONSTRAINT orders_customerid_fkey
FOREIGN KEY (customerid) REFERENCES customers(customerid)
ON DELETE SET NULL;
DELETE FROM customers
WHERE customerid ='VINET';
 SELECT * FROM customers
 WHERE customerid = 'VINET';
 5.
 INSERT INTO products(productid,productname,quantityperunit,unitprice,discontinued,categoryid)
VALUES (100,'Wheat bread',1,13,'0',3),
        (101,'Wheat bread',5,13,'0',3);
SELECT * FROM products
WHERE productid = 100;
INSERT INTO products(productid,productname,quantityperunit,unitprice,discontinued,categoryid)
VALUES (100,'Wheat bread',10,13,'0',3)
        ON CONFLICT (productid)
        DO UPDATE
        SET productname = EXCLUDED.productname,
        quantityperunit = EXCLUDED.quantityperunit,
        unitprice =EXCLUDED.unitprice,
        discontinued= EXCLUDED.discontinued,
        categoryid =EXCLUDED.categoryid;
SELECT * FROM products
WHERE productid = 100;
6.
INSERT INTO updated_products(productid,productname,quantityperunit,unitprice,discontinued,categoryid)
VALUES (100,'Wheat bread',10,20,'1',3),
        (101,'Wheat bread','5 boxes',19.99,'0',3),
        (102,'Midnight Mango Fizz','24 - 12 oz bottles',19,'0',1),
        (103,'Savory Fire Sauce','12 - 550 ml bottles',10,'0',2);
SELECT * FROM updated_products;
SELECT * FROM products WHERE productid IN (100,101,102,103);
MERGE INTO products p
USING updated_products u
ON p.productid = u.productid
WHEN MATCHED AND u.discontinued = '0' THEN
UPDATE SET unitprice = 21 ,
            discontinued = '1'
WHEN MATCHED AND u.discontinued = '1' THEN
DELETE
WHEN NOT MATCHED AND u.discontinued = '0' THEN
INSERT(productid,productname,quantityperunit,unitprice,discontinued,categoryid)
VALUES (u.productid,u.productname,u.quantityperunit,u.unitprice,u.discontinued,u.categoryid);
SELECT * FROM products;










Shift + Enter to add a new line