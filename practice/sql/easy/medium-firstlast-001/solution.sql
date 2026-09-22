-- Xom Data · Lần đầu và lần gần nhất của mỗi khách
-- Problem: https://xomdata.com/practice/medium-firstlast-001
-- Solved: 2026-09-22

select customer_id,
    min(order_date) as first_order_date,
    max(order_date) as last_order_date
from orders
group by customer_id
order by customer_id asc;
