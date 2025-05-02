/*Create view vw_updatable_products (use same query whatever I used in the training)
Try updating view with below query and see if the product table also gets updated.
Update query:
UPDATE updatable_products SET unit_price = unit_price * 1.1 WHERE units_in_stock < 10;*/

CREATE VIEW vw_updatable_products AS
SELECT
    product_id,
    product_name,
    unit_price,
    units_in_stock
FROM
    products;
UPDATE vw_updatable_products
SET unit_price = unit_price * 1.1
WHERE units_in_stock < 10;
SELECT
    product_id,
    product_name,
    unit_price,
    units_in_stock
FROM
    products
WHERE
    units_in_stock < 10;

	/*Transaction:
Update the product price for products by 10% in category id=1
Try COMMIT and ROLLBACK and observe what happens. */

select 
product_id,product_name,category_id,unit_price
from Products where category_id=1;

select round(((((26.353798/1.1)/1.1)/1.1)/1.1))

START TRANSACTION;
UPDATE products
SET unit_price = unit_price * 1.1
WHERE category_id = 1;
Rollback;

START TRANSACTION;
UPDATE products
SET unit_price = unit_price * 1.1
WHERE category_id = 1;
commit;







/*  Create a regular view which will have below details (Need to do joins):
Employee_id,
Employee_full_name,
Title,
Territory_id,
territory_description,
region_description
*/

Create view Employee_Territory
as
select 
a.employee_id,
concat(a.first_name,' ',a.last_name) as Employee_full_name,
a.title,
b.territory_id,
c.territory_description,
d.region_description
from 
employees a
inner join employee_territories b
on a.employee_id=b.employee_id
inner join territories c
on b.territory_id=c.territory_id
inner join region d
on c.region_id=d.region_id

select * from Employee_Territory;


/* 4.     Create a recursive CTE based on Employee Hierarchy */



WITH RECURSIVE EmployeeHierarchy AS (
    SELECT
        employee_id,
        first_name,
        last_name,
        reports_to,
        1 AS level,
        CAST(first_name || ' ' || last_name AS VARCHAR(255)) AS path
    FROM
        employees
    WHERE
        reports_to IS NULL

    UNION ALL

    SELECT
        e.employee_id,
        e.first_name,
        e.last_name,
        e.reports_to,
        eh.level + 1 AS level,
        CAST(eh.path || ' -> ' || e.first_name || ' ' || e.last_name AS VARCHAR(255)) AS path
    FROM
        employees e
    JOIN
        EmployeeHierarchy eh ON e.reports_to = eh.employee_id
)

SELECT
    employee_id,
    first_name,
    last_name,
    reports_to,
    level,
    path
FROM
    EmployeeHierarchy
ORDER BY
    level, path;


	