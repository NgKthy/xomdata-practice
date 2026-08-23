-- Xom Data · Ai ghé đủ cả hai tháng liền nhau
-- Problem: https://xomdata.com/practice/medium-active-002
-- Solved: 2026-08-23

select customer_id
from orders
where substr(order_date, 1, 7) in ('2024-03', '2024-04')
group by customer_id
having count(distinct substr(order_date, 1, 7)) = 2;
