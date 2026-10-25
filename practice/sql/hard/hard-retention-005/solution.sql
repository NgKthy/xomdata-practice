-- Xom Data · Surviving from the second month onward
-- Problem: https://xomdata.com/practice/hard-retention-005
-- Solved: 2026-10-25

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
survivors as (
    select c.customer_id, c.cohort_start,
        exists (
            select 1
            from activity a
            where a.customer_id = c.customer_id
              and a.activity_month >= (c.cohort_start + interval '2 month')::date
        ) as survived
    from cohorts c
)
select to_char(cohort_start, 'yyyy-mm') as cohort_month,
    count(*) as cohort_size,
    sum(case when survived then 1 else 0 end) as survivors,
    round(
        100.0 * sum(case when survived then 1 else 0 end) / count(*),
        2
    ) as survival_pct
from survivors
group by cohort_start
order by cohort_start;
