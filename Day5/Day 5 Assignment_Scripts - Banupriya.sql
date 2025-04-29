---------------------Day 5 - SQL Scripts: Banupriya
--1.Display, order year, quarter, order count, avg freight cost only for those orders where freight cost > 100

SELECT
	EXTRACT(
		YEAR
		FROM
			ORDER_DATE
	) AS ORDER_YEAR,
	EXTRACT(
		QUARTER
		FROM
			ORDER_DATE
	) AS QUARTER,
	COUNT(*) AS ORDER_COUNT,
	ROUND(AVG(FREIGHT)::NUMERIC, 2) AS AVG_FREIGHT_COST
FROM
	ORDERS
WHERE
	FREIGHT > 100
GROUP BY
	ORDER_YEAR,
	QUARTER
ORDER BY
	ORDER_YEAR,
	QUARTER;

--2.Display, ship region, no of orders in each region, min and max freight cost, Filter regions where no of orders >= 5

SELECT
	SHIP_REGION,
	COUNT(*) AS ORDERCOUNT_REGIONWISE,
	MIN(FREIGHT) AS MIN_FREIGHT,
	MAX(FREIGHT) AS MAX_FREIGHT
FROM
	ORDERS
GROUP BY
	SHIP_REGION
HAVING
	COUNT(*) >= 5
ORDER BY
	ORDERCOUNT_REGIONWISE DESC;

--3.      Get all title designations across employees and customers ( Try UNION & UNION ALL)

-- Using Union
SELECT
	CONCAT(FIRST_NAME, ' ', LAST_NAME) AS NAME,
	TITLE AS TITLE_DESIGNATION,
	'Employee' AS SOURCE
FROM
	EMPLOYEES
UNION
SELECT
	CONTACT_NAME AS NAME,
	CONTACT_TITLE AS TITLE_DESIGNATION,
	'Customer' AS SOURCE
FROM
	CUSTOMERS;

-- Using Union ALL
SELECT
	CONCAT(FIRST_NAME, ' ', LAST_NAME) AS NAME,
	TITLE AS TITLE_DESIGNATION,
	'Employee' AS SOURCE
FROM
	EMPLOYEES
UNION ALL
SELECT
	CONTACT_NAME AS NAME,
	CONTACT_TITLE AS TITLE_DESIGNATION,
	'Customer' AS SOURCE
FROM
	CUSTOMERS;

--4.      Find categories that have both discontinued and in-stock products (Display category_id, instock means units_in_stock > 0, Intersect)

-- Categories with at least one in-stock product
SELECT
	CATEGORY_ID
FROM
	PRODUCTS
WHERE
	UNITS_IN_STOCK > 0
INTERSECT
-- Categories with at least one discontinued product
SELECT
	CATEGORY_ID
FROM
	PRODUCTS
WHERE
	DISCONTINUED = 1
ORDER BY
	CATEGORY_ID;

--5.      Find orders that have no discounted items (Display the  order_id, EXCEPT)

SELECT
	ORDER_ID,
	DISCOUNT
FROM
	ORDER_DETAILS
EXCEPT
SELECT DISTINCT
	ORDER_ID,
	DISCOUNT
FROM
	ORDER_DETAILS
WHERE
	DISCOUNT > 0;
