-- Xom Data · Tháng bùng nổ khách mới
-- Problem: https://xomdata.com/practice/medium-active-003
-- Solved: 2026-08-23

with first_orders as(
    select customer_id, min(order_date) as first_date
    from orders
    group by customer_id
),
monthly_new as(
    select substr(first_date, 1, 7) as month,
        count(*) as new_customers
    from first_orders
    group by month
)
select month, new_customers
from monthly_new
order by new_customers desc, month
limit 1;
