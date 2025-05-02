1. /*    List all customers and the products they ordered with the order date. (Inner join)
Tables used: customers, orders, order_details, products
Output should have below columns:
    companyname AS customer,
    orderid,
    productname,
    quantity, */	
    
    
Select * from customers;
select * from orders;
select * from order_details;
Select * From Products;


select  
a.company_name as customer,
b.order_id,
d.product_name,
c.quantity,
b.order_date
from customers a
inner join orders b
on a.customer_id = b.customer_id
inner join order_details c
on b.order_id = c.order_id
inner join Products d
on c.product_id = d.product_id

select * from orders;
Select * from customers where  customer_id  in
(select customer_id from orders);
Select * from employees;
Select * from shippers;
select * from order_details;
Select * From Products;


/*2.     Show each order with customer, employee, shipper, and product info — even if some parts are missing. (Left Join)
Tables used: orders, customers, employees, shippers, order_details, products
*/

select  
a.order_id,
b.company_name,
c.first_name,
c.last_name,
f.shipper_id,
e.product_name
from orders a
left join customers b
on a.customer_id = b.customer_id
left join employees c#
on a.employee_id = c.employee_id
left join order_details d
on a.order_id=d.order_id
left join Products e
on d.product_id = e.product_id
left join shippers f
on b.company_name=f.company_name


/*3.     Show all order details and products (include all products even if they were never ordered). (Right Join)
Tables used: order_details, products
Output should have below columns:
    orderid,
    productid,
    quantity,
    productname
*/

select 
a.order_id,
a.quantity,
b.product_name,
b.product_id
from order_details a
right join Products b
on a.product_id=b.product_id


/*4. 	List all product categories and their products — including categories that have no products, and products that are not assigned to any category.(Outer Join)
Tables used: categories, products
*/

Select  
a.category_name,
a.description,
a.picture,
b.product_name,
b.product_id
from categories a
full outer join Products b
on a.category_id = b.category_id

/* 5. 	Show all possible product and category combinations (Cross join).*/


SELECT
    Products.Product_Name,
    Categories.Category_Name
FROM
    Products
CROSS JOIN
    Categories;

/*6. 	Show all employees and their manager(Self join(left join))*/


SELECT
    a.first_name AS Employee_FN,
    b.last_name AS HR_LN
FROM
    employees a
LEFT JOIN
    employees b ON a.employee_id = b.employee_id;


/* 7. 	List all customers who have not selected a shipping method.
Tables used: customers, orders
(Left Join, WHERE o.shipvia IS NULL)*/

select  
a.company_name as customer,
b.order_id,
b.ship_via
from customers a
left join orders b
on a.customer_id = b.customer_id
where b.ship_via is null