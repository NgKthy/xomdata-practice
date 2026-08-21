-- Xom Data · Delivered orders
-- Problem: https://xomdata.com/practice/easy-where-003
-- Solved: 2026-08-21

select order_code, customers, total_amount
from orders
where status = 'Delivered'
order by id;
