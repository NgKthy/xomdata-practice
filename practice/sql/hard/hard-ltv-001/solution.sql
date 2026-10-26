-- Xom Data · Average lifetime value by cohort
-- Problem: https://xomdata.com/practice/hard-ltv-001
-- Solved: 2026-10-26

with first_orders as (
    select customer_id,
        min(order_date::date) as first_date
    from orders
    group by customer_id
),
customer_ltv as (
    select customer_id,
        sum(amount) as ltv
    from orders
    group by customer_id
),
cohorts as (
    select f.customer_id,
        to_char(f.first_date, 'yyyy-mm') as cohort_month
    from first_orders f
)
select c.cohort_month,
    count(*) as cohort_size,
    round(avg(cl.ltv), 2) as avg_ltv
from cohorts c
join customer_ltv cl
    on cl.customer_id = c.customer_id
group by c.cohort_month
order by c.cohort_month;
