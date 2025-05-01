1.Rank employees by their total sales
(Total sales = Total no of orders handled, JOIN employees and orders table)

select * from orders;
select
employee_id,
count(*)as total_sales,
RANK() OVER (order by count(*)desc) as sales_rank
from orders
group by
employee_id;


-------------------------------------------

////SELECT 
	employee_id, 
	order_id, 
	 
	RANK() OVER (ORDER BY employee_id) totalsales
FROM 
	orders;


2.      Compare current order's freight with previous and next order for each customer.
(Display order_id,  customer_id,  order_date,  freight,
Use lead(freight) and lag(freight).

select * from customers;
select * from orders;

SELECT
customer_id,
order_date,
order_id,
freight,
LAG(freight,1) over (partition by customer_id order by order_date) as Previousorders,  
LEAD(freight,1) over (partition by customer_id order by order_date) as Nextorders
from orders;
-------------------------------------------------------
3.Show products and their price categories, product count in each category, avg price:
        	(HINT:
	Create a CTE which should have price_category definition:
        	WHEN unit_price < 20 THEN 'Low Price'
            WHEN unit_price < 50 THEN 'Medium Price'
            ELSE 'High Price'
			In the main query display: price_category,  product_count in each price_category,  ROUND(AVG(unit_price)::numeric, 2) as avg_price)


select * from products;

select 
category_id AS TotalCategory
from products
GROUP BY category_id;
\\\\\\\\\\\\\\\\\\\\\\\\\\\
WITH price_category_cte AS (
SELECT category_id,unit_price,
				CASE
				WHEN unit_price < 20 THEN 'Low Price'
 				WHEN unit_price < 50 THEN 'Medium Price'
				ELSE 'HIGH PRICE' END AS price_category FROM products
				)
 SELECT price_category,COUNT(*) AS product_count,ROUND(AVG(unit_price)::numeric, 2) as avg_price
 			FROM price_category_cte
			 GROUP BY price_category;










	