---------------------Day 4 - SQL Scripts: Banupriya
/*1.     List all customers and the products they ordered with the order date.
Output should have below columns:
    companyname AS customer,
    orderid,
    productname,
    quantity,
    orderdate*/
	
SELECT
	C.COMPANY_NAME AS CUSTOMER,
	O.ORDER_ID,
	P.PRODUCT_NAME,
	OD.QUANTITY,
	O.ORDER_DATE
FROM
	ORDERS O
	INNER JOIN ORDER_DETAILS OD ON O.ORDER_ID = OD.ORDER_ID
	INNER JOIN PRODUCTS P ON P.PRODUCT_ID = OD.PRODUCT_ID
	INNER JOIN CUSTOMERS C ON C.CUSTOMER_ID = O.CUSTOMER_ID;

--2.     Show each order with customer, employee, shipper, and product info — even if some parts are missing.

SELECT
	O.ORDER_ID,
	C.CUSTOMER_ID,
	C.CONTACT_NAME AS CUSTOMERNAME,
	CONCAT(E.FIRST_NAME, ' ', E.LAST_NAME) AS EMPLOYEENAME,
	S.COMPANY_NAME AS SHIPPERNAME,
	P.PRODUCT_NAME,
	P.UNIT_PRICE
FROM
	ORDERS O
	LEFT JOIN CUSTOMERS C ON C.CUSTOMER_ID = O.CUSTOMER_ID
	LEFT JOIN EMPLOYEES E ON E.EMPLOYEE_ID = O.EMPLOYEE_ID
	LEFT JOIN SHIPPERS S ON S.SHIPPER_ID = O.SHIP_VIA
	LEFT JOIN ORDER_DETAILS OD ON O.ORDER_ID = OD.ORDER_ID
	LEFT JOIN PRODUCTS P ON P.PRODUCT_ID = OD.PRODUCT_ID
ORDER BY
	O.ORDER_ID;

/*3.     Show all order details and products (include all products even if they were never ordered). 
Output should have below columns:
    orderid,
    productid,
    quantity,
    productname*/

SELECT
	OD.ORDER_ID,
	P.PRODUCT_ID,
	OD.QUANTITY,
	P.PRODUCT_NAME
FROM
	ORDER_DETAILS OD
	RIGHT JOIN PRODUCTS P ON OD.PRODUCT_ID = P.PRODUCT_ID;

/*4. 	List all product categories and their products — including categories that have no products, and products that are not assigned to any category.*/

SELECT
	P.PRODUCT_ID,
	P.PRODUCT_NAME,
	P.CATEGORY_ID,
	C.CATEGORY_NAME
FROM
	PRODUCTS P
	FULL OUTER JOIN CATEGORIES C ON P.CATEGORY_ID = C.CATEGORY_ID;

--5. 	Show all possible product and category combinations.

SELECT
	P.PRODUCT_ID,
	P.PRODUCT_NAME,
	P.CATEGORY_ID,
	C.CATEGORY_NAME
FROM
	PRODUCTS P
	CROSS JOIN CATEGORIES C;

--6. 	Show all employees and their manager

SELECT
	EMP.EMPLOYEE_ID,
	CONCAT(EMP.FIRST_NAME, ' ', EMP.LAST_NAME) AS EMPLOYEENAME,
	EMP.TITLE AS EMPLOYEETITLE,
	EMP.REPORTS_TO AS REPORTS_TO_MANAGERID,
	CONCAT(MANAGER.FIRST_NAME, ' ', MANAGER.LAST_NAME) AS MANAGERNAME,
	MANAGER.TITLE AS MANAGERTITLE
FROM
	EMPLOYEES EMP
	LEFT JOIN EMPLOYEES MANAGER ON EMP.REPORTS_TO = MANAGER.EMPLOYEE_ID
ORDER BY
	EMP.REPORTS_TO DESC;


/*7. 	List all customers who have not selected a shipping method.*/

SELECT
	C.CUSTOMER_ID,
	C.COMPANY_NAME,
	C.CONTACT_NAME,
	O.SHIP_VIA
FROM
	CUSTOMERS C
	LEFT JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID
WHERE
	O.SHIP_VIA IS NULL;
