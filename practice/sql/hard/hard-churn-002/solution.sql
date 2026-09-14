-- Xom Data · Tháng này mất bao nhiêu khách của tháng trước
-- Problem: https://xomdata.com/practice/hard-churn-002
-- Solved: 2026-09-14

with customer_months as (
    select distinct
        customer_id,
        strftime('%Y-%m', order_date) as month
    from orders
),
max_month as (
    select max(month) as max_month
    from customer_months
),
months_to_check as (
    select distinct month
    from customer_months
    where month < (select max_month from max_month)
)
select
    m.month,
    count(cm.customer_id) as churned_customers
from months_to_check m
left join customer_months cm
    on cm.month = m.month
   and not exists (
       select 1
       from customer_months cm2
       where cm2.customer_id = cm.customer_id
         and cm2.month = strftime(
             '%Y-%m',
             date(m.month || '-01', '+1 month')
         )
   )
group by m.month
order by m.month;
