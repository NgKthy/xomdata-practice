-- Xom Data · Tháng chào sân của từng khách
-- Problem: https://xomdata.com/practice/medium-cohort-003
-- Solved: 2026-08-21

select customer_id, substr(min(order_date), 1, 7) as cohort_month
from orders
group by customer_id
order by cohort_month, customer_id;
