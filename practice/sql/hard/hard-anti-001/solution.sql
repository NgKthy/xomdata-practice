-- Xom Data · Customers silent for 90 days
-- Problem: https://xomdata.com/practice/hard-anti-001
-- Solved: 2026-09-22

with last_orders as (
    select user_id, max(order_date) as last_order_date
    from orders
    group by user_id
),
cutoff as (
    select max(order_date) as max_date
    from orders
)
select lo.user_id, lo.last_order_date,
    cast(
        julianday((select max_date from cutoff)) - julianday(lo.last_order_date)
        as integer
    ) as days_since_last
from last_orders lo
where cast(
        julianday((select max_date from cutoff)) - julianday(lo.last_order_date)
        as integer
      ) >= 90
order by days_since_last desc, lo.user_id;
