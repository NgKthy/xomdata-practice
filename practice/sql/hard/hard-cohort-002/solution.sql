-- Xom Data · Repeat-customer tracking table by cohort
-- Problem: https://xomdata.com/practice/hard-cohort-002
-- Solved: 2026-10-17

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
activity as (
    select distinct customer_id,
        date_trunc('month', order_date::date)::date as activity_month
    from orders
),
cohort_activity as (
    select c.cohort_start, c.customer_id,
        (
            extract(year from a.activity_month) - extract(year from c.cohort_start)
        ) * 12
        + (
            extract(month from a.activity_month) - extract(month from c.cohort_start)
        ) as month_offset
    from cohorts c
    join activity a
        on a.customer_id = c.customer_id
)
select to_char(cohort_start, 'yyyy-mm') as cohort_month,
    count(distinct case when month_offset = 0 then customer_id end) as m0,
    count(distinct case when month_offset = 1 then customer_id end) as m1,
    count(distinct case when month_offset = 2 then customer_id end) as m2,
    count(distinct case when month_offset = 3 then customer_id end) as m3
from cohort_activity
group by cohort_start
order by cohort_start;
