-- Xom Data · Đồng hồ đếm ngược trước khi mất khách
-- Problem: https://xomdata.com/practice/medium-churn-003
-- Solved: 2026-08-23

with customer_last as(
    select customer_id, max(order_date) as last_order_date
    from orders
    group by customer_id
)
select customer_id,
    cast(julianday('2024-06-30') - julianday(last_order_date) as integer) as days_silent,
    cast(90 - (julianday('2024-06-30') - julianday(last_order_date)) as integer) as days_left
from customer_last
where julianday('2024-06-30') - julianday(last_order_date) <= 90
order by days_left asc, customer_id asc;
