-- Xom Data · Number of delivered orders
-- Problem: https://xomdata.com/practice/easy-count-002
-- Solved: 2026-08-19

select count(id) as order_count
from orders
where status = 'Delivered';
