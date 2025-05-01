---------------------Day 7 - SQL Scripts: Banupriya
/*1.     Rank employees by their total sales
(Total sales = Total no of orders handled, JOIN employees and orders table)*/
SELECT
	EMPLOYEE_ID,
	COUNT(ORDER_ID) AS TOTAL_SALES,
	RANK() OVER (
		ORDER BY
			COUNT(ORDER_ID) DESC
	) AS EMPLOYEES_RANK
FROM
	ORDERS
GROUP BY
	EMPLOYEE_ID
ORDER BY
	EMPLOYEES_RANK;

/*2.      Compare current orders freight with previous and next order for each customer.
(Display order_id,  customer_id,  order_date,  freight,
Use lead(freight) and lag(freight).*/
SELECT
	ORDER_ID,
	CUSTOMER_ID,
	ORDER_DATE,
	FREIGHT AS CURRENT_ORDER_FREIGHT,
	LAG(FREIGHT, 1, 0) OVER (
		PARTITION BY
			CUSTOMER_ID
		ORDER BY
			ORDER_DATE
	) AS PREVIOUS_ORDER_FREIGHT,
	LEAD(FREIGHT, 1, 0) OVER (
		PARTITION BY
			CUSTOMER_ID
		ORDER BY
			ORDER_DATE
	) AS NEXT_ORDER_FREIGHT
FROM
	ORDERS;

/*3.     Show products and their price categories, product count in each category, avg price:
(HINT:
·  	Create a CTE which should have price_category definition:
WHEN unit_price < 20 THEN 'Low Price'
WHEN unit_price < 50 THEN 'Medium Price'
ELSE 'High Price'
·  	In the main query display: price_category,  product_count in each price_category,  ROUND(AVG(unit_price)::numeric, 2) as avg_price)*/
WITH
	PRICE_CATEGORY AS (
		SELECT
			PRODUCT_ID,
			UNIT_PRICE,
			CATEGORY_ID,
			CASE
				WHEN UNIT_PRICE < 20 THEN 'Low Price'
				WHEN UNIT_PRICE < 50 THEN 'Medium Price'
				ELSE 'High Price'
			END AS PRICE_CATEGORY
		FROM
			PRODUCTS
	)
SELECT
	CATEGORY_ID,
	COUNT(*) AS PRODUCTS_COUNT,
	ROUND(AVG(UNIT_PRICE)::NUMERIC, 2) AS AVG_PRICE,
	PRICE_CATEGORY
FROM
	PRICE_CATEGORY
GROUP BY
	CATEGORY_ID,
	PRICE_CATEGORY
ORDER BY
	CATEGORY_ID,
	AVG_PRICE;
