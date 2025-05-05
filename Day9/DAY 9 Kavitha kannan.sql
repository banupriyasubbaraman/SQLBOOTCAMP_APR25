1./* Create product_price_audit table with below columns:
	audit_id SERIAL PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(40),
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_name VARCHAR(50) DEFAULT CURRENT_USER
 
·       Create a trigger function with the below logic:
 
  INSERT INTO product_price_audit (
        product_id,
        product_name,
        old_price,
        new_price
    )
    VALUES (
        OLD.product_id,
        OLD.product_name,
        OLD.unit_price,
        NEW.unit_price
    );
·       Create a row level trigger for below event:
          	AFTER UPDATE OF unit_price ON products
 
·        Test the trigger by updating the product price by 10% to any one product_id.*/
 
 --create the product_price_audit table
	CREATE table product_price_audit (
	audit_id SERIAL PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(40),
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_name VARCHAR(50) DEFAULT CURRENT_USER
 
);
--1.Define the trigger FUNCTION
	CREATE or REPLACE FUNCTION product_price_audit_function()
	returns trigger as $$
	BEGIN

--2. Insert into product_price_audit TABLE
	INSERT into product_price_audit(
 		product_id,
        product_name,
        old_price,
        new_price
    )
	VALUES(
		old.product_id,
        old.product_name,
        old.unit_price,
        new.unit_price
	
);

--3.RETURN the new ROW
	RETURN new;
	end;
	$$ LANGUAGE plpgsql;

	SELECT * FROM PRODUCT_PRICE_AUDIT;
	select * from products;

--create the TRIGGER
	create trigger after_product_insert
	AFTER UPDATE OF unit_price ON products
	for each row
	execute function product_price_audit_function();

	SELECT * from products where product_id=3;

--test the trigger by updating the product price by 10% to any one product_id.
	UPDATE products
 	set unit_price=unit_price *1.10
    where product_id=3;

 	select * from products where product_id=3;
	select * from product_price_audit;

	select * from log_new_product;
----------------------------------------------------------------------
2./* Create stored procedure  using IN and INOUT parameters to assign tasks to employees
 
·   Parameters:
		IN p_employee_id INT,
		IN p_task_name VARCHAR(50),
 		INOUT p_task_count INT DEFAULT 0
 
·  Inside Logic: Create table employee_tasks:
 		CREATE TABLE IF NOT EXISTS employee_tasks (
        task_id SERIAL PRIMARY KEY,
        employee_id INT,
        task_name VARCHAR(50),
        assigned_date DATE DEFAULT CURRENT_DATE
    );
 
·       1.Insert employee_id, task_name  into employee_tasks
·      2. Count total tasks for employee and put the total count into p_task_count .
·      3. Raise NOTICE message:
 		  RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %',
          p_task_name, p_employee_id, p_task_count;
 
 
		After creating stored procedure test by calling  it:
 		CALL assign_task(1, 'Review Reports');
 
		You should see the entry in employee_tasks table.*/
 
 -- Create table employee_tasks
 
 CREATE TABLE IF NOT EXISTS employee_tasks (
        task_id SERIAL PRIMARY KEY,
        employee_id INT,
        task_name VARCHAR(50),
        assigned_date DATE DEFAULT CURRENT_DATE
    );
 
select * from employee_tasks;
	
 -- Create a Stored Procedure 
CREATE or REPLACE procedure assign_tasks
	(
		IN p_employee_id INT,
		IN p_task_name VARCHAR(50),
 		INOUT p_task_count INT DEFAULT 0
    )
LANGUAGE plpgsql
as $$
BEGIN
 --insert employee_id,task_name INTO employee_tasks
  		
 		insert into employee_tasks(employee_id,task_name)
		values(p_employee_id,p_task_name);
		 
 --count total tasks
		select count(task_id) INTO p_task_count
		from employee_tasks
		where employee_id=p_employee_id;
--raise notice message:
		 
 		RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %',
        p_task_name, p_employee_id, p_task_count;
 		
END;
$$;
CALL  assign_tasks(1,'Review Reports');

SELECT * from employee_tasks;



