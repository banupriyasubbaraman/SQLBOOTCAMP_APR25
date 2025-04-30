1./*Categorize products by stock status
(Display product_name, a new column stock_status
whose values are based on below condition
 units_in_stock = 0  is 'Out of Stock'
       units_in_stock < 20  is 'Low Stock')*/
SELECT
	product_name,
	units_in_stock as stock_status,
CASE
	when units_in_stock=0 Then 'Out of Stock'
	when units_in_stock<20 Then 'Low Stock'
ELSE
	'Available'
end as stock_status
from products
ORDER BY units_in_stock;

/* Find All Products in Beverages Category
(Subquery, Display product_name,unitprice)
*/
select * from categories;
select * from products;
select
	product_name,
	unit_price,
	category_id
from
	products
where category_id=(
select category_id
from categories
where category_name='Beverages'
);
select category_id
from categories
where category_name='Beverages';

3./*  Find Orders by Employee with Most Sales
(Display order_id,   order_date,  freight, employee_id.
Employee with Most Sales=Get the total no.of of orders
for each employee then order by DESC and limit 1. Use Subquery)*/
select * from orders;
select
	order_id,
	order_date,
	freight,
	employee_id
	
FROM
	orders
WHERE
	employee_id=(
	select employee_id
	from orders
	group by employee_id
	order by count(order_id)DESC
	limit 1
);
select employee_id
	from orders
	group by employee_id
	order by employee_id DESC
	limit 1;

4./*   Find orders  where for country!= ‘USA’ with freight
costs higher than any order from USA.
(Subquery, Try with ANY, ALL operators)*/
select
order_id,
ship_country,
freight
from
 orders
 where ship_country!='USA'
 and freight> any (
     select freight
	 from orders
	 where ship_country='USA'
	  order by freight
 )
 group by
      order_id;
select * from orders;
select freight,ship_country
from orders
where ship_country='USA'
order by freight;
select
order_id,
ship_country,
freight
from
orders
where ship_country!='USA'
order by freight;




















