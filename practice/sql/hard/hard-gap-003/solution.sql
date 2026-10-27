-- Xom Data · Predicting the customer's next visit date
-- Problem: https://xomdata.com/practice/hard-gap-003
-- Solved: 2026-10-27

with ordered as (
    select customer_id, order_id,
        order_date::date as order_date,
        lag(order_date::date) over (
            partition by customer_id
            order by order_date::date asc, order_id asc
        ) as prev_date
    from orders
),
gaps as (
    select customer_id, order_date,
        order_date - prev_date as gap_days
    from ordered
    where prev_date is not null
),
stats as (
    select customer_id,
        max(order_date) as last_order_date,
        floor(avg(gap_days))::int as avg_gap_days
    from gaps
    group by customer_id
)
select customer_id, last_order_date, avg_gap_days,
    (last_order_date + avg_gap_days) as predicted_next_date
from stats
order by predicted_next_date, customer_id;
