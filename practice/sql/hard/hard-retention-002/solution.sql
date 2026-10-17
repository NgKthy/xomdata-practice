-- Xom Data · How much is left after one month
-- Problem: https://xomdata.com/practice/hard-retention-002
-- Solved: 2026-10-17

with first_orders as (
    select customer_id,
        min(order_date)::date as first_date
    from orders
    group by customer_id
),
cohorts as (
    select customer_id,
        to_char(first_date, 'yyyy-mm') as cohort_month,
        first_date
    from first_orders
),
retained as (
    select
        c.customer_id,
        c.cohort_month,
        exists (
            select 1
            from orders o
            where o.customer_id = c.customer_id
              and o.order_date::date >= (date_trunc('month', c.first_date) + interval '1 month')::date
              and o.order_date::date < (date_trunc('month', c.first_date) + interval '2 month')::date
        ) as retained_m1
    from cohorts c
)
select cohort_month,
    count(*) as cohort_size,
    sum(case when retained_m1 then 1 else 0 end) as retained_m1,
    round(
        100.0 * sum(case when retained_m1 then 1 else 0 end) / count(*),
        2
    ) as retention_pct
from retained
group by cohort_month
order by cohort_month;
