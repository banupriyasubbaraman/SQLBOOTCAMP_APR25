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

Select contact_name,contact_title From customers
union 
Select concat(first_name,'',last_name) as Fullname,title from employees;

Select contact_name,contact_title From customers
union all
Select concat(first_name,'',last_name) as Fullname,title from employees;

SELECT  category_id
FROM products
WHERE discontinued = 0 AND units_in_stock > 0
INTERSECT
SELECT  category_id
FROM products
WHERE discontinued = 1;

SELECT order_id
FROM orders
EXCEPT
SELECT order_id
FROM order_details
WHERE discount > 0;



	