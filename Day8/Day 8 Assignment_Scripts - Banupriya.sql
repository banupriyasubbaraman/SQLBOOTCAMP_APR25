---------------------Day 8 - SQL Scripts: Banupriya
/*1.     Create view vw_updatable_products (use same query whatever I used in the training)
Try updating view with below query and see if the product table also gets updated.
Update query:
UPDATE updatable_products SET unit_price = unit_price * 1.1 WHERE units_in_stock < 10;*/

---- Create Updatable view statement
CREATE VIEW VW_UPDATABLE_PRODUCTS AS
SELECT
	PRODUCT_ID,
	PRODUCT_NAME,
	UNIT_PRICE,
	UNITS_IN_STOCK,
	DISCONTINUED
FROM
	PRODUCTS
WHERE
	DISCONTINUED = 0
WITH
	CHECK OPTION;

---- Update statement
UPDATE VW_UPDATABLE_PRODUCTS
SET
	UNIT_PRICE = UNIT_PRICE * 1.1
WHERE
	UNITS_IN_STOCK < 10;

--- TO check the products table and the view
SELECT
	*
FROM
	PRODUCTS
WHERE
	UNITS_IN_STOCK < 10;

SELECT
	*
FROM
	VW_UPDATABLE_PRODUCTS
WHERE
	UNITS_IN_STOCK < 10;

/*2.     Transaction:
Update the product price for products by 10% in category id=1
Try COMMIT and ROLLBACK and observe what happens.*/

------ Update Statement as Transaction
BEGIN;

UPDATE PRODUCTS
SET
	UNIT_PRICE = UNIT_PRICE * 1.10
WHERE
	CATEGORY_ID = 1;

------ Transaction to check condition and raise exception
DO $$
BEGIN
		IF EXISTS (
		SELECT 1 from products where category_id = 1 and unit_price > 20		
		) 
		THEN
			RAISE EXCEPTION 'some prices exceed $20';		
		ELSE
			RAISE NOTICE 'price update successful';
		END IF;
END $$;

------- Commit and Rollback Statements
COMMIT;

ROLLBACK;

-------- TO check the products table
SELECT
	*
FROM
	PRODUCTS
WHERE
	CATEGORY_ID = 1;

/*3.     Create a regular view which will have below details (Need to do joins):
Employee_id,
Employee_full_name,
Title,
Territory_id,
territory_description,
region_description */

------ Create View Statement
CREATE VIEW VW_EMPLOYEE_LOCATION AS
SELECT
	E.EMPLOYEE_ID,
	CONCAT(E.FIRST_NAME, ' ', E.LAST_NAME) AS EMPLOYEE_FULL_NAME,
	E.TITLE,
	T.TERRITORY_ID,
	T.TERRITORY_DESCRIPTION,
	R.REGION_DESCRIPTION
FROM
	EMPLOYEE_TERRITORIES ET
	INNER JOIN TERRITORIES T ON ET.TERRITORY_ID = T.TERRITORY_ID
	INNER JOIN EMPLOYEES E ON ET.EMPLOYEE_ID = E.EMPLOYEE_ID
	INNER JOIN REGION R ON T.REGION_ID = R.REGION_ID;

------- To check the created view
SELECT
	*
FROM
	VW_EMPLOYEE_LOCATION;

--4.     Create a recursive CTE based on Employee Hierarchy

WITH RECURSIVE
	CTE_EMP_HIERARCHY AS (
		-- Shows the First list of Managers who dont report to anyone
		SELECT
			E.EMPLOYEE_ID,
			CONCAT(E.FIRST_NAME, ' ', E.LAST_NAME) AS EMPLOYEE_FULL_NAME,
			E.REPORTS_TO,
			1 AS LEVEL
		FROM
			EMPLOYEES E
		WHERE
			REPORTS_TO IS NULL
		UNION ALL
		-- Recursive case: List of employees reporting to managers
		SELECT
			E.EMPLOYEE_ID,
			CONCAT(E.FIRST_NAME, ' ', E.LAST_NAME) AS EMPLOYEE_FULL_NAME,
			E.REPORTS_TO,
			EH.LEVEL + 1
		FROM
			EMPLOYEES E
			JOIN CTE_EMP_HIERARCHY EH ON EH.EMPLOYEE_ID = E.REPORTS_TO
	)
SELECT
	LEVEL,
	EMPLOYEE_ID,
	EMPLOYEE_FULL_NAME,
	REPORTS_TO
FROM
	CTE_EMP_HIERARCHY;
