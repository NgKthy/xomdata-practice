-- Xom Data · Ai chuyên cần suốt cả quý
-- Problem: https://xomdata.com/practice/medium-active-004
-- Solved: 2026-08-23

select customer_id
from orders
where substr(order_date, 1, 7) in ('2024-01', '2024-02', '2024-03')
group by customer_id
having count(distinct substr(order_date, 1, 7)) = 3;
