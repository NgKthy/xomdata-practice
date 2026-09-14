-- Xom Data · Người mới và người quen mỗi tháng
-- Problem: https://xomdata.com/practice/hard-cohort-003
-- Solved: 2026-09-14

with first_order as (
    select customer_id, min(order_date) as first_date
    from orders
    group by customer_id
),
customer_months as (
    select distinct customer_id,
        strftime('%Y-%m', order_date) as month
    from orders
),
joined as (
    select cm.month, cm.customer_id,
        strftime('%Y-%m', fo.first_date) as first_month
    from customer_months cm
    join first_order fo on fo.customer_id = cm.customer_id
)
select month,
    sum(case when first_month = month then 1 else 0 end) as new_customers,
    sum(case when first_month < month then 1 else 0 end) as returning_customers
from joined
group by month
order by month;
