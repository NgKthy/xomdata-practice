-- Xom Data · Những người quay về sau hai tháng im ắng
-- Problem: https://xomdata.com/practice/hard-winback-001
-- Solved: 2026-09-23

with prev as (
    select customer_id, order_date,
        lag(order_date) over (
            partition by customer_id
            order by order_date, order_id
        ) as prev_date
    from orders
)
select customer_id, order_date,
    cast(julianday(order_date) - julianday(prev_date) as integer) as gap_days
from prev
where prev_date is not null
  and julianday(order_date) - julianday(prev_date) >= 60;
