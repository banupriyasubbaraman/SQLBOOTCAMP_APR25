select * from categories where category_id=1;

update categories set category_name='Drinks' where category_id=1;

select * from shippers;

insert into shippers values(7,'garuda vegha',1-800-225-5454);
update shippers set phone='1-800-225-5454' where shipper_id=7;
Delete from shippers where shipper_id=7;



ALTER TABLE products
DROP CONSTRAINT fk_products_categories;

ALTER TABLE products
ADD CONSTRAINT fk_products_categories
FOREIGN KEY (category_iD)
REFERENCES public.categories (category_id) 
ON UPDATE CASCADE
ON DELETE CASCADE;

select * from categories;
UPDATE Categories
SET category_ID = 1001
WHERE category_ID = 1;
select * from products;

select * from order_details;

ALTER TABLE order_details
DROP CONSTRAINT fk_order_details_products;

ALTER TABLE order_details
ADD CONSTRAINT fk_order_details_products
FOREIGN KEY (product_id)
REFERENCES public.products (product_id)
ON UPDATE CASCADE
ON DELETE CASCADE;

Delete from categories where category_id=3;

select * from categories where category_id=3;

select * from products where category_id=3;

Select * From customers where customer_id='VINET';
ALTER TABLE orders
DROP CONSTRAINT fk_orders_customers;

ALTER TABLE orders
Add CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id)
        REFERENCES public.customers (customer_id)
ON DELETE SET NULL;

Select * From orders 
where customer_id is null;
Delete from customers where customer_id='VINET';

select * from products;

insert into products (product_id, product_name, quantity_per_unit, unit_price, discontinued,category_id)
values
 (100, 'Wheat bread', '1 box', 13, 0, 5),
  (101, 'White bread', '5 boxes', 13, 0, 5),
  (102, 'Wheat bread', '10 boxes', 13, 0, 5)

  CREATE TEMP TABLE updated_products (
    productID INT,
    productName VARCHAR(255),
    quantityPerUnit VARCHAR(255),
    unitPrice DECIMAL(10, 2),
    discontinued INT,
    categoryID INT
);

select * from updated_products

INSERT INTO updated_products (productID, productName, quantityPerUnit, unitPrice, discontinued, categoryID)
VALUES
    (100, 'Wheat bread', '10', 20.00, 1, 5),
    (101, 'White bread', '5 boxes', 19.99, 0, 5),
    (102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19.00, 0, 1),
    (103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10.00, 0, 2);

	MERGE INTO Products AS target
USING updated_products AS source
ON target.product_ID = source.productID
WHEN MATCHED AND source.discontinued = 0 THEN
    UPDATE SET
        unit_price = source.unitPrice,
        discontinued = source.discontinued
WHEN MATCHED AND source.discontinued = 1 THEN
    DELETE
WHEN NOT MATCHED BY TARGET AND source.discontinued = 0 THEN
    INSERT (product_id,product_name,quantity_per_unit,unit_price,discontinued,category_id)
    VALUES (source.productID, source.productName, source.quantityPerUnit, source.unitPrice, source.discontinued, source.categoryID);


DROP TABLE updated_products;

select concat(a.first_name,' ',a.last_name) as FullName,b.* from employees a
inner join 3 b
on a.employee_id = b.employee_id
