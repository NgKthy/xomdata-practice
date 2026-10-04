-- Xom Data · Nhật ký vòng đời từng khách mỗi tháng
-- Problem: https://xomdata.com/practice/hard-churn-005
-- Solved: 2026-10-04

with customer_months as (
    select distinct customer_id,
        strftime('%Y-%m', order_date) as month
    from orders
),
first_months as (
    select customer_id,
        min(month) as first_month
    from customer_months
    group by customer_id
),
prev_check as (
    select cm.customer_id, cm.month, fm.first_month,
        exists (
            select 1
            from customer_months cm2
            where cm2.customer_id = cm.customer_id
              and cm2.month = strftime('%Y-%m', date(cm.month || '-01', '-1 month'))
        ) as has_prev
    from customer_months cm
    join first_months fm
        on fm.customer_id = cm.customer_id
)
select month, customer_id,
    case
        when month = first_month then 'new'
        when has_prev = 1 then 'retained'
        else 'resurrected'
    end as lifecycle
from prev_check
order by month, customer_id;
