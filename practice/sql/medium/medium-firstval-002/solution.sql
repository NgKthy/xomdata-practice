-- Xom Data · First purchase date next to every order
-- Problem: https://xomdata.com/practice/medium-firstval-002
-- Solved: 2026-10-21

-- Write your SQL here
select customer_name, order_date, amount,
    min(order_date) over (
        partition by customer_name
    ) as first_order_date
from orders
order by customer_name, order_date;
