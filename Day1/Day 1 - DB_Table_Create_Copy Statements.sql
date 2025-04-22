----------------------------------------------------------------------------------------
---------------------------- Create Database Statement---------------------------
----------------------------------------------------------------------------------------

-- Database: NorthwindTraders

-- DROP DATABASE IF EXISTS "NorthwindTraders";

CREATE DATABASE "NorthwindTraders"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

----------------------------------------------------------------------------------------
---------------------------- Create Table Statements---------------------------
----------------------------------------------------------------------------------------

----------- Table 1: categories------------------------------------------------
-- Table: public.categories

-- DROP TABLE IF EXISTS public.categories;

CREATE TABLE IF NOT EXISTS public.categories
(
    "categoryID" smallint NOT NULL,
    "categoryName" character varying(100) COLLATE pg_catalog."default",
    description character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT categories_pkey PRIMARY KEY ("categoryID")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.categories
    OWNER to postgres;


----------- Table 2: customers------------------------------------------------
-- Table: public.customers

-- DROP TABLE IF EXISTS public.customers;

CREATE TABLE IF NOT EXISTS public.customers
(
    "customerID" character varying(50) NOT NULL,
    "companyName" character varying(150) COLLATE pg_catalog."default",
    "contactName" character varying(100) COLLATE pg_catalog."default",
    "contactTitle" character varying(120) COLLATE pg_catalog."default",
    city character varying(70) COLLATE pg_catalog."default",
    country character varying(100) COLLATE pg_catalog."default",
	CONSTRAINT customer_pkey PRIMARY KEY ("customerID")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.customers
    OWNER to postgres;

----------- Table 3: datadictionary------------------------------------------------
-- Table: public.datadictionary

-- DROP TABLE IF EXISTS public.datadictionary;

CREATE TABLE IF NOT EXISTS public.datadictionary
(
    Tablename character varying(50) COLLATE pg_catalog."default",
    Field character varying(50) COLLATE pg_catalog."default",
    Description character varying(255) COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.datadictionary
    OWNER to postgres;

----------- Table 4: employees------------------------------------------------
-- Table: public.employees

-- DROP TABLE IF EXISTS public.employees;

CREATE TABLE IF NOT EXISTS public.employees
(
    "employeeID" smallint NOT NULL,
    "employeeName" character varying(100) COLLATE pg_catalog."default",
    "title" character varying(100) COLLATE pg_catalog."default",
    city character varying(70) COLLATE pg_catalog."default",
    country character varying(50) COLLATE pg_catalog."default",
	reportsTo  smallint,
	CONSTRAINT employee_pkey PRIMARY KEY ("employeeID")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.employees
    OWNER to postgres;

----------- Table 5: shippers------------------------------------------------
-- Table: public.shippers

-- DROP TABLE IF EXISTS public.shippers;

CREATE TABLE IF NOT EXISTS public.shippers
(
    "shipperID" smallint NOT NULL,
    "companyName" character varying(100) COLLATE pg_catalog."default",
	CONSTRAINT shipper_pkey PRIMARY KEY ("shipperID")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.shippers
    OWNER to postgres;

----------- Table 6: orders------------------------------------------------
-- Table: public.orders

-- DROP TABLE IF EXISTS public.orders;

CREATE TABLE IF NOT EXISTS public.orders
(
    "orderID" smallint NOT NULL,
    "customerID" character varying(50) NOT NULL,
    "employeeID" smallint NOT NULL,
    orderDate date,
    requiredDate date,
	shippedDate date,
	"shipperID" smallint NOT NULL,
	freight double precision NOT NULL,
	CONSTRAINT order_pkey PRIMARY KEY ("orderID"),
	CONSTRAINT order_customerid_fkey FOREIGN KEY ("customerID")
        REFERENCES public.customers ("customerID"),
	CONSTRAINT order_employeeid_fkey FOREIGN KEY ("employeeID")
        REFERENCES public.employees ("employeeID"),
	CONSTRAINT order_shipperid_fkey FOREIGN KEY ("shipperID")
        REFERENCES public.shippers ("shipperID")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.orders
    OWNER to postgres;

----------- Table 7: products------------------------------------------------
-- Table: public.products

-- DROP TABLE IF EXISTS public.products;

CREATE TABLE IF NOT EXISTS public.products
(
    "productID" smallint NOT NULL,
    productName character varying(250) NOT NULL,
    quantityPerUnit character varying(250) NOT NULL,
    unitPrice double precision NOT NULL,
    discontinued boolean,
	"categoryID" smallint NOT NULL,
	CONSTRAINT product_pkey PRIMARY KEY ("productID"),
	CONSTRAINT product_categoryid_fkey FOREIGN KEY ("categoryID")
        REFERENCES public.categories ("categoryID")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.products
    OWNER to postgres;

----------- Table 8: orderdetails------------------------------------------------
-- Table: public.orderdetails

-- DROP TABLE IF EXISTS public.orderdetails;

CREATE TABLE IF NOT EXISTS public.orderdetails
(
    "orderID" smallint NOT NULL,
    "productID" smallint NOT NULL,
    unitPrice double precision NOT NULL,
    quantity smallint NOT NULL,
    discount double precision,
    CONSTRAINT orderdetails_pkey PRIMARY KEY ("orderID", "productID"),
    CONSTRAINT orderdetails_orderid_fkey FOREIGN KEY ("orderID")
        REFERENCES public.orders ("orderID"),
    CONSTRAINT orderdetails_productid_fkey FOREIGN KEY ("productID")
        REFERENCES public.products ("productID")
);

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.orderdetails
    OWNER to postgres;

----------------------------------------------------------------------------------------
------- Copy Commands -----------------------------------------------------------------
----------------------------------------------------------------------------------------

----------- Table 1: categories------------------------------------------------
COPY categories
FROM 'C:\Banu\BanuWork\SQL\Bootcamp_Apr2025\archive\categories.csv'
DELIMITER ','
CSV HEADER;

select * from categories

----------- Table 2: customers------------------------------------------------
COPY customers
FROM 'C:\Banu\BanuWork\SQL\Bootcamp_Apr2025\archive\customers.csv'
WITH (
    FORMAT csv,
    DELIMITER ',',
    HEADER,
    ENCODING 'LATIN1'
);

select * from customers

----------- Table 3: datadictionary------------------------------------------------
COPY datadictionary
FROM 'C:\Banu\BanuWork\SQL\Bootcamp_Apr2025\archive\data_dictionary.csv'
DELIMITER ','
CSV HEADER;

select * from datadictionary

----------- Table 4: employees------------------------------------------------
COPY employees
FROM 'C:\Banu\BanuWork\SQL\Bootcamp_Apr2025\archive\employees.csv'
DELIMITER ','
CSV HEADER;

select * from employees

----------- Table 5: shippers------------------------------------------------
COPY shippers
FROM 'C:\Banu\BanuWork\SQL\Bootcamp_Apr2025\archive\shippers.csv'
DELIMITER ','
CSV HEADER;

select * from shippers

----------- Table 6: orders------------------------------------------------
COPY orders
FROM 'C:\Banu\BanuWork\SQL\Bootcamp_Apr2025\archive\orders.csv'
DELIMITER ','
CSV HEADER;

select * from orders

----------- Table 7: products------------------------------------------------
COPY products
FROM 'C:\Banu\BanuWork\SQL\Bootcamp_Apr2025\archive\products.csv'
WITH (
    FORMAT csv,
    DELIMITER ',',
    HEADER,
    ENCODING 'LATIN1'
);

select * from products

----------- Table 8: orderdetails------------------------------------------------
COPY orderdetails
FROM 'C:\Banu\BanuWork\SQL\Bootcamp_Apr2025\archive\order_details.csv'
DELIMITER ','
CSV HEADER;

select * from orderdetails	
