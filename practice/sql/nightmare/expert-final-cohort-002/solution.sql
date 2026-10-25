-- Xom Data · Next-month customer retention rate by cohort
-- Problem: https://xomdata.com/practice/expert-final-cohort-002
-- Solved: 2026-10-25

with user_months as (
    select distinct user_id,
        to_char(order_date::date, 'yyyy-mm') as month
    from orders
),
monthly_users as (
    select month,
        count(distinct user_id) as first_month_users
    from user_months
    group by month
),
returned as (
    select um.month,
        count(distinct um.user_id) as return_count
    from user_months um
    join user_months um2
        on um2.user_id = um.user_id
       and um2.month = to_char((um.month || '-01')::date + interval '1 month', 'yyyy-mm')
    group by um.month
)
select mu.month as first_month, mu.first_month_users,
    coalesce(r.return_count, 0) as return_count,
    round(coalesce(r.return_count, 0) * 100.0 / mu.first_month_users, 1) as retention_rate
from monthly_users mu
left join returned r
    on r.month = mu.month
order by mu.month;
