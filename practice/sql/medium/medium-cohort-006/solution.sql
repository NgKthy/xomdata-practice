-- Xom Data · Tuổi đời mua sắm của khách
-- Problem: https://xomdata.com/practice/medium-cohort-006
-- Solved: 2026-08-23

with customer_dates as (
    select customer_id,
        min(order_date) as first_date,
        max(order_date) as last_date
    from orders
    group by customer_id
)
select customer_id,
    substr(first_date, 1, 7) as first_month,
    substr(last_date, 1, 7) as last_month,
    (cast(substr(last_date, 1, 4) as integer) - cast(substr(first_date, 1, 4) as integer)) * 12 + (cast(substr(last_date, 6, 2) as integer) - cast(substr(first_date, 6, 2) as integer)) as tenure_months
from customer_dates
order by tenure_months desc, customer_id;
