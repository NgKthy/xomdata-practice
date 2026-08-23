-- Xom Data · Sổ đen những khách đã im lặng quá lâu
-- Problem: https://xomdata.com/practice/medium-churn-004
-- Solved: 2026-08-23

select customer_id, 
    max(order_date) as last_order_date,
    cast(julianday('2024-06-30') - julianday(max(order_date)) as integer) as days_silent
from orders
group by customer_id
having cast(julianday('2024-06-30') - julianday(max(order_date)) as integer) > 90
order by days_silent desc, customer_id;
