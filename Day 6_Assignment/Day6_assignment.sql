/*1.      Categorize products by stock status
(Display product_name, a new column stock_status whose values are based on below condition
 units_in_stock = 0  is 'Out of Stock'
       units_in_stock < 20  is 'Low Stock')*/


select product_name, 
case when units_in_stock = 0 then  'Out of Stock'
when units_in_stock < 20  then  'Low Stock'
end as stock_status 
from products;


/*2.      Find All Products in Beverages Category
(Subquery, Display product_name,unitprice)*/

Select product_name ,unit_price from Products where category_id in
(select  category_id 
from Categories
where category_name='Drinks')



/*3.      Find Orders by Employee with Most Sales
(Display order_id,   order_date,  freight, employee_id.
Employee with Most Sales=Get the total no.of of orders for each employee then order by DESC and limit 1. Use Subquery)
*/

SELECT order_id, order_date, freight, employee_id
FROM orders
WHERE employee_id = (
    SELECT employee_id
    FROM (
        SELECT employee_id, COUNT(order_id) AS total_orders
        FROM orders
        GROUP BY employee_id
        ORDER BY total_orders DESC
        LIMIT 1
    ) AS employee_orders
);

/* 4.      Find orders  where for country!= ‘USA’ with freight costs higher than any order from USA.
(Subquery, Try with ANY, ALL operators) */

select Order_id, freight,ship_country from orders where ship_country!='USA'
and freight > ALL (select freight from orders where ship_country='USA') 
