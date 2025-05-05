---------------------Day 9 - SQL Scripts: Banupriya
/*1.      Create AFTER UPDATE trigger to track product price changes

·       Create product_price_audit table with below columns:
audit_id SERIAL PRIMARY KEY,
product_id INT,
product_name VARCHAR(40),
old_price DECIMAL(10,2),
new_price DECIMAL(10,2),
change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
user_name VARCHAR(50) DEFAULT CURRENT_USER */

--- Table creation Statement
CREATE TABLE PRODUCT_PRICE_AUDIT (
	AUDIT_ID SERIAL PRIMARY KEY,
	PRODUCT_ID INT,
	PRODUCT_NAME VARCHAR(40),
	OLD_PRICE DECIMAL(10, 2),
	NEW_PRICE DECIMAL(10, 2),
	CHANGE_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	USER_NAME VARCHAR(50) DEFAULT CURRENT_USER
);

/*·       Create a trigger function with the below logic:

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
);*/

----- Trigger Function creation statement:
CREATE
OR REPLACE FUNCTION PRODUCT_PRICE_AUDIT_TRIGGERFN () RETURNS TRIGGER AS $$
BEGIN
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

    RETURN NEW;
END;
$$ LANGUAGE PLPGSQL;

/*·       Create a row level trigger for below event:
AFTER UPDATE OF unit_price ON products*/

------ Row Level Trigger creation statement			  
CREATE TRIGGER PRODUCT_PRICE_AUDIT_TRIGGER
AFTER
UPDATE ON PRODUCTS FOR EACH ROW WHEN (OLD.UNIT_PRICE IS DISTINCT FROM NEW.UNIT_PRICE)
EXECUTE FUNCTION PRODUCT_PRICE_AUDIT_TRIGGERFN ();

--·        Test the trigger by updating the product price by 10% to any one product_id.

------ Testing the trigger by updating product price for product_id = 1:
UPDATE PRODUCTS
SET
	UNIT_PRICE = UNIT_PRICE * 1.10
WHERE
	PRODUCT_ID = 1;

----- checking the audit table
SELECT
	*
FROM
	PRODUCT_PRICE_AUDIT;

/*2.      Create stored procedure  using IN and INOUT parameters to assign tasks to employees

·       Parameters:
IN p_employee_id INT,
IN p_task_name VARCHAR(50),
INOUT p_task_count INT DEFAULT 0

·       Inside Logic: Create table employee_tasks:
CREATE TABLE IF NOT EXISTS employee_tasks (
task_id SERIAL PRIMARY KEY,
employee_id INT,
task_name VARCHAR(50),
assigned_date DATE DEFAULT CURRENT_DATE
);*/

------ Table creation statement:
CREATE TABLE IF NOT EXISTS EMPLOYEE_TASKS (
	TASK_ID SERIAL PRIMARY KEY,
	EMPLOYEE_ID INT,
	TASK_NAME VARCHAR(50),
	ASSIGNED_DATE DATE DEFAULT CURRENT_DATE
);

/*·       Insert employee_id, task_name  into employee_tasks
·       Count total tasks for employee and put the total count into p_task_count .
·       Raise NOTICE message:
RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %',
p_task_name, p_employee_id, p_task_count;
*/

------ Create procedure statement
CREATE
OR REPLACE PROCEDURE ASSIGN_TASK (
	IN P_EMPLOYEE_ID INT,
	IN P_TASK_NAME VARCHAR(50),
	INOUT P_TASK_COUNT INT DEFAULT 0
) LANGUAGE PLPGSQL AS $$
BEGIN
    insert into employee_tasks(employee_id,task_name)values(p_employee_id,p_task_name);
	select count(*) into p_task_count from employee_tasks where employee_id = p_employee_id;
 	RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %',
        p_task_name, p_employee_id, p_task_count;
END;
$$;

--After creating stored procedure test by calling  it:

-------- SP call statements:
CALL ASSIGN_TASK (1, 'Review Reports');

CALL ASSIGN_TASK (1, 'Update Dashboard');

--You should see the entry in employee_tasks table.

-------- checking the employee_tasks table for the new entries.
SELECT
	*
FROM
	EMPLOYEE_TASKS;
