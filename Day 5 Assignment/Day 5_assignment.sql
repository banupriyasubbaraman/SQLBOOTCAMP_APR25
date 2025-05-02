/*1.      GROUP BY with WHERE - Orders by Year and Quarter
Display, order year, quarter, order count, avg freight cost only for those orders where freight cost > 100*/

select  
order_id,
extract(Year from order_date)as Orderyear,
extract(Quarter From order_date ) as OrderQuarter,
order_Date,
Count(*),
avg(freight)
from orders
group by order_id,extract(Year from order_date),extract(Quarter From order_date ),order_Date
having avg(freight)>100 
;

/*2.      GROUP BY with HAVING - High Volume Ship Regions
Display, ship region, no of orders in each region, min and max freight cost
 Filter regions where no of orders >= 5*/

SELECT
    ship_region,
    COUNT(order_id) AS total_orders,
    MIN(freight) AS min_freight,
    MAX(freight) AS max_freight
FROM
    orders
GROUP BY
    ship_region
HAVING
    COUNT(order_id) >= 5
ORDER BY
    total_orders DESC;


/*3.      Get all title designations across employees and customers ( Try UNION & UNION ALL)*/

Select contact_name,contact_title From customers
union 
Select concat(first_name,'',last_name) as Fullname,title from employees;

Select contact_name,contact_title From customers
union all
Select concat(first_name,'',last_name) as Fullname,title from employees;

/*4.      Find categories that have both discontinued and in-stock products
(Display category_id, instock means units_in_stock > 0, Intersect)*/

SELECT  category_id
FROM products
WHERE discontinued = 0 AND units_in_stock > 0
INTERSECT
SELECT  category_id
FROM products
WHERE discontinued = 1;

/*5.      Find orders that have no discounted items (Display the  order_id, EXCEPT)*/

SELECT order_id
FROM orders
EXCEPT
SELECT order_id
FROM order_details
WHERE discount > 0;



	