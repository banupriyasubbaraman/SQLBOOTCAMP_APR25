
select * from order_details;
select * from products;
select * from employees;
select * from shippers;
select * from categories;
1.     List all customers and the products they ordered with the order date. (Inner join)
Tables used: customers, orders, order_details, products
Output should have below columns:
    companyname AS customer,
    orderid,
    productname,
    quantity,
    orderdate////
select
c.company_name as customer,
o.order_id,
p.product_name,
od.quantity,
o.order_date
FROM customers c
INNER JOIN orders o ON c.customer_id=o.customer_id
INNER JOIN order_details od ON o.order_id=od.order_id
INNER JOIN products p ON od.product_id=p.product_id;

//2. Show each order with customer, employee, shipper, and product info — even if some parts are missing. (Left Join)
Tables used: orders, customers, employees, shippers, order_details, products
//
select
 o.order_id,
 c.company_name AS customer,
 e.first_name||' '|| e.last_name AS employee_name,
 s.company_name AS shippers,
 p.product_name,
 od.quantity
from orders o
LEFT JOIN customers c ON c.customer_id=o.customer_id
LEFT JOIN employees e ON e.employee_id=o.employee_id
LEFT JOIN shippers s ON o.ship_via=s.shipper_id
LEFT JOIN order_details od ON o.order_id=od.order_id
LEFT JOIN products p ON od.product_id=p.product_id;
3.   Show all order details and products (include all products even if they were never ordered). (Right Join)
Tables used: order_details, products
Output should have below columns:
    orderid,
    productid,
    quantity,
    productname
	
 select
od.order_id ,
p.product_id,
od.quantity,
p.product_name
from order_details od
RIGHT JOIN products p ON p.product_id=od.product_id;


4. 	List all product categories and their products — including categories that have no products, and products that are not assigned to any category.(Outer Join)
Tables used: categories, products
select
ca.category_id,
ca.category_name,
p.product_name
from categories ca
FULL OUTER JOIN products p ON ca.category_id=p.category_id;
 ------------------------------------------------------------
5. 	Show all possible product and category combinations (Cross join).
select
ca.category_id,
ca.category_name,
p.product_id,
p.Product_name
from categories ca
CROSS JOIN products p;
-------------------------------------------------------
6.Show all employees and their manager(Self join(left join))
select
e1.first_name || ' ' || e1.last_name AS employee_name,
e2.first_name || ' ' || e2.last_name AS manager_name
from employees e1
LEFT JOIN employees e2 ON e1.reports_to = e2.employee_id;
 
7. 	List all customers who have not selected a shipping method.
Tables used: customers, orders
(Left Join, WHERE o.shipvia IS NULL)

select
c.company_name AS customers,
o.ship_via
from customers c
LEFT JOIN orders o ON c.customer_id=o.customer_id
where o.ship_via isnull;