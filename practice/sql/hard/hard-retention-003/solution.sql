-- Xom Data · Còn quay lại trong tuần kế tiếp không
-- Problem: https://xomdata.com/practice/hard-retention-003
-- Solved: 2026-09-23

with customer_cohort as (
    select customer_id,
        min(order_date) as first_date,
        cast((julianday(min(order_date)) - julianday('2024-01-01')) / 7 as integer) + 1 as cohort_week
    from orders
    group by customer_id
),
order_weeks as (
    select customer_id,
        cast((julianday(order_date) - julianday('2024-01-01')) / 7 as integer) + 1 as order_week
    from orders
),
retained as (
    select cc.customer_id, cc.cohort_week,
        case
            when exists (
                select 1
                from order_weeks ow
                where ow.customer_id = cc.customer_id
                  and ow.order_week = cc.cohort_week + 1
            ) then 1
            else 0
        end as retained
    from customer_cohort cc
)
select cohort_week,
    count(*) as cohort_size,
    sum(retained) as retained_next_week
from retained
group by cohort_week
order by cohort_week;
