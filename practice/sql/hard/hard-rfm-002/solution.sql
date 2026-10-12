-- Xom Data · Assigning customers to the right care segment
-- Problem: https://xomdata.com/practice/hard-rfm-002
-- Solved: 2026-10-12

with stats as (
    select customer_id,
        max(order_date) as last_order_date,
        count(*) as order_count
    from orders
    group by customer_id
)
select customer_id,
    cast(julianday('2024-06-30') - julianday(last_order_date) as integer) as days_since,
    order_count,
    case
        when julianday('2024-06-30') - julianday(last_order_date) <= 60
             AND order_count >= 3 then 'Champions'
        when julianday('2024-06-30') - julianday(last_order_date) > 60
             AND order_count >= 3 then 'At Risk'
        when julianday('2024-06-30') - julianday(last_order_date) <= 60
             AND order_count < 3 then 'Promising'
        else 'Hibernating'
    end as segment
from stats;
