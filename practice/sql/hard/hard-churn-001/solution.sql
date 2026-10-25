-- Xom Data · Churned and returning customers
-- Problem: https://xomdata.com/practice/hard-churn-001
-- Solved: 2026-10-25

with prev_orders as (
    select user_id, order_date,
        lag(order_date) over (
            partition by user_id
            order by order_date::date, id 
        ) as prev_order
    from orders
)
select user_id, prev_order,
    order_date as next_order,
    order_date::date - prev_order::date as gap_days
from prev_orders
where prev_order is not null
  and order_date::date - prev_order::date >= 90
order by gap_days desc, user_id;
