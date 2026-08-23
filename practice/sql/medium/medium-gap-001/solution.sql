-- Xom Data · Khoảng lặng giữa hai lần mua liền kề
-- Problem: https://xomdata.com/practice/medium-gap-001
-- Solved: 2026-08-23

with ordered as(
    select customer_id, order_date, order_id,
        lag(order_date) over(
                            partition by customer_id
                            order by order_date, order_id) as prev_order_date
    from orders
)
select customer_id, order_date, cast(julianday(order_date) - julianday(prev_order_date) as integer) as days_since_prev
from ordered
where prev_order_date is not null
order by customer_id, order_date, days_since_prev;
