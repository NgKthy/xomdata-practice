-- Xom Data · Cumulative revenue by cohort age
-- Problem: https://xomdata.com/practice/hard-ltv-002
-- Solved: 2026-10-28

with first_orders as (
    select customer_id,
        min(order_date::date) as first_date
    from orders
    group by customer_id
),
cohorts as (
    select customer_id,
        date_trunc('month', first_date)::date as cohort_start
    from first_orders
),
order_ages as (
    select c.cohort_start,
        (
            extract(year from date_trunc('month', o.order_date::date)::date)
            - extract(year from c.cohort_start)
        ) * 12
        + (
            extract(month from date_trunc('month', o.order_date::date)::date)
            - extract(month from c.cohort_start)
        ) as month_age,
        o.amount
    from orders o
    join cohorts c
        on c.customer_id = o.customer_id
),
aggregated as (
    select cohort_start, month_age,
        sum(amount) as revenue
    from order_ages
    group by cohort_start, month_age
)
select to_char(cohort_start, 'yyyy-mm') as cohort_month,
    month_age, revenue,
    sum(revenue) over (
        partition by cohort_start
        order by month_age
        rows between unbounded preceding and current row
    ) as cumulative_revenue
from aggregated
order by cohort_start, month_age;
