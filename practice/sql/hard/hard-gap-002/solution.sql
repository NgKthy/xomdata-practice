-- Xom Data · The longest silence period for each customer
-- Problem: https://xomdata.com/practice/hard-gap-002
-- Solved: 2026-10-26

with ordered as (
    select customer_id, order_id,
        order_date::date as order_date,
        lag(order_date::date) over (
            partition by customer_id
            order by order_date::date, order_id 
        ) as prev_date
    from orders
),
gaps as (
    select customer_id,
        prev_date as gap_start,
        order_date as gap_end,
        order_date - prev_date as gap_days
    from ordered
    where prev_date is not null
),
ranked as (
    select customer_id, gap_start, gap_end, gap_days,
        row_number() over (
            partition by customer_id
            order by gap_days desc, gap_start, gap_end 
        ) as rn
    from gaps
)
select customer_id, gap_start, gap_end, gap_days
from ranked
where rn = 1
order by gap_days desc, customer_id;
