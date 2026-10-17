-- Xom Data · Monthly customer churn rate
-- Problem: https://xomdata.com/practice/hard-churn-003
-- Solved: 2026-10-17

with customer_months as (
    select distinct customer_id,
        to_char(order_date::date, 'yyyy-mm') as month
    from orders
),
max_month as (
    select max(month) as max_month
    from customer_months
),
active as (
    select month,
        count(distinct customer_id) as active_customers
    from customer_months
    where month < (select max_month from max_month)
    group by month
),
churned as (
    select cm.month,
        count(distinct cm.customer_id) as churned_customers
    from customer_months cm
    where cm.month < (select max_month from max_month)
      and not exists (
          select 1
          from customer_months cm2
          where cm2.customer_id = cm.customer_id
            and cm2.month = to_char(
                ((cm.month || '-01')::date + interval '1 month')::date,
                'yyyy-mm'
            )
      )
    group by cm.month
)
select a.month, a.active_customers,
    coalesce(c.churned_customers, 0) as churned_customers,
    round(
        coalesce(c.churned_customers, 0) * 100.0 / nullif(a.active_customers, 0),
        2
    ) as churn_rate_pct
from active a
left join churned c
    on c.month = a.month
order by a.month;
