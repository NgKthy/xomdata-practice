-- Xom Data · The customer's joining month on every order
-- Problem: https://xomdata.com/practice/medium-cohort-001
-- Solved: 2026-10-13

-- Write your SQL here
with first_orders as (
    select customer_name,
        min(order_date) as first_order_date
    from orders
    group by customer_name
)
select o.customer_name, o.order_date,
    substr(f.first_order_date, 1, 7) as cohort_month
from orders o
join first_orders f
    on f.customer_name = o.customer_name
order by o.customer_name, o.order_date;
