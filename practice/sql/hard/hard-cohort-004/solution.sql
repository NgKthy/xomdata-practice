-- Xom Data · Customer cohorts viewed by acquisition channel
-- Problem: https://xomdata.com/practice/hard-cohort-004
-- Solved: 2026-10-17

with first_orders as (
    select o.customer_id,
        min(o.order_date::date) as first_date
    from orders o
    join customers c
        on c.customer_id = o.customer_id
    group by o.customer_id
),
base as (
    select c.channel, f.customer_id,
        date_trunc('month', f.first_date)::date as cohort_start
    from first_orders f
    join customers c
        on c.customer_id = f.customer_id
),
retained as (
    select b.channel, b.cohort_start, b.customer_id,
        exists (
            select 1
            from orders o
            where o.customer_id = b.customer_id
              and o.order_date::date >= (b.cohort_start + interval '1 month')::date
              and o.order_date::date < (b.cohort_start + interval '2 month')::date
        ) as retained_m1
    from base b
)
select
    channel,
    to_char(cohort_start, 'yyyy-mm') as cohort_month,
    count(*) as cohort_size,
    sum(case when retained_m1 then 1 else 0 end) as retained_m1
from retained
group by channel, cohort_start
order by channel, cohort_start;
