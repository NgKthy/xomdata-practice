-- Xom Data · Average spend per visit, per customer
-- Problem: https://xomdata.com/practice/medium-monetary-002
-- Solved: 2026-09-22

select customer_id,
    round(avg(amount), 2) as avg_order_value
from orders
group by customer_id;
