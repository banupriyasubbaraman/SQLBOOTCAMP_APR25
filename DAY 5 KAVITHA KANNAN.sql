1).select * from orders;

select
    extract(year from order_date)as order_year,
    extract(quarter from order_date)as quarter,
    count(*)as ordercount,
    avg(freight)as freightcost
from orders
     where freight>100
     group by extract(year from order_date),
              extract(quarter from order_date);
order by
       order_year,quarter;
2)
select * from shippers;
select * from region;
select
   ship_region,
   count(*) as number_of_orders,
   min(freight)as min_freight,
   max(freight)as max_freight,
   round(sum(freight)::numeric,2)as total_frieght
from orders
group by
   ship_region
having
   count(*)>=5 and ship_region is not null
order by
   total_frieght desc;
 -------------------------------------------------------------------------------------------
 3.
select * from employees;
select * from customers;
select title as designation
from employees
union
select contact_title as designation
from customers;
select title as designation
from employees
union all
select contact_title as designation
from customers
4.   Find categories that have both discontinued and in-stock products
(Display category_id, instock means units_in_stock > 0, Intersect)
*/
select * from products;
select
category_id
from products
where units_in_stock>0
intersect
select
category_id
from products
where discontinued=1
order by category_id


5 Find orders that have no discounted items (Display the  order_id, EXCEPT)*/
select order_id,discount
from order_details
except
select order_id,discount
from order_details
where discount!=0





















