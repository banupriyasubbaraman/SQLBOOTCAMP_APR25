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

select 
a.order_id,
a.quantity,
b.product_name,
b.product_id
from order_details a
right join Products b
on a.product_id=b.product_id

Select  
a.category_name,
a.description,
a.picture,
b.product_name,
b.product_id
from categories a
full outer join Products b
on a.category_id = b.category_id



SELECT
    Products.Product_Name,
    Categories.Category_Name
FROM
    Products
CROSS JOIN
    Categories;


SELECT
    a.first_name AS Employee_FN,
    b.last_name AS HR_LN
FROM
    employees a
LEFT JOIN
    employees b ON a.employee_id = b.employee_id;

select  
a.company_name as customer,
b.order_id,
b.ship_via
from customers a
left join orders b
on a.customer_id = b.customer_id
where b.ship_via is null