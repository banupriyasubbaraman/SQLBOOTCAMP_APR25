 
1.     Create view vw_updatable_products (use same query whatever I used in the training)
Try updating view with below query and see if the product table also gets updated.
Update query:

UPDATE updatable_products SET unit_price = unit_price * 1.1 WHERE units_in_stock < 10;

------------------
select * from products;
select * from vw_updatable_products;
CREATE view vw_updatable_products AS
select
 	product_id,
	 product_name,
	 unit_price,
	 units_in_stock,
	 discontinued
from products
	 where discontinued=0
	 with  CHECK option;
	
UPDATE vw_updatable_products
set unit_price=unit_price*1.1
where units_in_stock<10;
----------------------------------------------------------------
2.     Transaction:
Update the product price for products by 10% in category id=1
Try COMMIT and ROLLBACK and observe what happens.


select * from products;
BEGIN;
	update products
	set unit_price=unit_price*1.10
where category_id=1;
commit;
rollback;
--------------------------------------
3.     Create a regular view which will have below details (Need to do joins):
Employee_id,
Employee_full_name,
Title,
Territory_id,
territory_description,
region_description//

select * from employees;
select * from employee_territories;
select * from region;
create VIEW vw_employee_territory AS
select
	e.employee_id,
	e.first_name||''||e.last_name as fullname,
	e.title,
	t.territory_id,
	t.territory_description,
	r.region_description
from employees e
JOIN employee_territories et ON et.employee_id=e.employee_id
join territories t ON t.territory_id = et.territory_id
JOIN region r ON r.region_id = t.region_id;
select * from vw_employee_territory;
-----------------------------------------------------------------------------
4./*Create a recursive CTE based on Employee Hierarchy///
with recursive cte_employee_hierarchy AS(
select
	employee_id,
	first_name,
	last_name,
	reports_to,0 as level
from employees e
where reports_to is null
union all
select
	e.employee_id,
	e.first_name,
	e.last_name,
	e.reports_to,eh.level+1
from employees e
join cte_employee_hierarchy eh ON eh.employee_id=e.reports_to)
select
	level,
	employee_id,
	first_name||''||last_name as fullname
	from cte_employee_hierarchy
	order by level,employee_id;






	
