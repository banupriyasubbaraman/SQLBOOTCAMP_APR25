select * from orders;
SELECT * from order_details;
SELECT c.contact_name,o.order_id ,first_name ||' '|| last_name AS employeename,product_name, s.company_name from orders o,customers c,employees emp,products prod,shippers s
LEFT JOIN orders 
ON order_id = s.shipper_id

SELECT c.contact_name,o.order_id ,first_name ||' '|| last_name AS employeename,product_name, s.company_name from orders o,customers c,employees emp,products prod,shippers s
LEFT JOIN orders 
ON order_id = order_details;

SELECT order_id from orders
