
ALTER TABLE employees
ADD COLUMN linkedin_profile varchar(30);
ALTER TABLE employees
ALTER COLUMN linkedin_profile TYPE text;
SELECT * FROM employees;
ALTER TABLE employees
ADD CONSTRAINT linkedin_profile UNIQUE(linkedin_profile);
ALTER TABLE employees
DROP COLUMN linkedin_profile;



select distinct unitPrice from products;
select * from customers order by companyName asc;
ALTER TABLE products rename column unitPrice to price_in_usd;
select * from products;
select  productname, price_in_usd from products;

Filtering:

select * from customers where country='Germany';
select * from customers where country='France' OR country= 'Spain';


//select 
4)Filtering:
select productID,productName,unitPrice
 from products where unitPrice>=15;

 select * from employees where country='USA'AND title='Sales Representative';
 select * from products where discontinued='1' AND unitPrice>30;

5)LIMIT/FETCH:

select * from orders limit 10;
select * from orders OFFSET 11 ROW FETCH NEXT 10 ROWS ONLY;(or)
select * from orders OFFSET 11 ROW limit 10;

6) Filtering:
select * from customers where contactTitle IN ('Sales Representative','Owner');
select * from orders where orderDate BETWEEN '1/1/2013' AND '12/13/2013';

7)filtering:
select * from products where categoryID NOT IN('1','2','3');
select * from customers where companyName like 'A%';
select * from orders;
INSERTING TABLE:
INSERT INTO orders (orderID,customerID,employeeID,orderDate,requiredDate,shippedDate,shipperID,freight) VALUES ('11078', 'ALFKI', '5', '4/23/2025', '04/30/202525','4/25/2025', '2','45.50');

UPDATE products
SET unitPrice=unitPrice*1.10
where categoryID=2;

 




