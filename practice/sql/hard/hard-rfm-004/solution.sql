-- Xom Data · Mã ba chữ số nói lên tất cả
-- Problem: https://xomdata.com/practice/hard-rfm-004
-- Solved: 2026-09-19

with stats as (
    select customer_id,
        max(order_date) as last_order,
        count(*) as freq,
        sum(amount) as monetary
    from orders
    where order_date <= '2024-06-30'
    group by customer_id
),
scores as (
    select customer_id,
        6 - ntile(5) over (order by last_order desc, customer_id) as r,
        6 - ntile(5) over (order by freq desc, customer_id) as f,
        6 - ntile(5) over(order by monetary desc, customer_id) as m
    from stats
)
select customer_id,
    cast(r as text) || cast (f as text) || cast(m as text) as rfm_code
from scores
order by rfm_code desc, customer_id;
