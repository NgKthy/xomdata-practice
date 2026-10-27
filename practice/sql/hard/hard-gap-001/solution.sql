-- Xom Data · Purchase rhythm and churn signal
-- Problem: https://xomdata.com/practice/hard-gap-001
-- Solved: 2026-10-27

with ordered as (
    select customer_id, order_id,
        order_date::date as order_date,
        lag(order_date::date) over (
            partition by customer_id
            order by order_date::date, order_id 
        ) as prev_date
    from orders
),
gaps as (
    select customer_id,
        order_date - prev_date as gap_days
    from ordered
    where prev_date is not null
),
stats as (
    select customer_id,
        round(avg(gap_days)::numeric, 1) as avg_gap_days
    from gaps
    group by customer_id
),
all_customers as (
    select distinct customer_id
    from orders
)
select c.customer_id, s.avg_gap_days,
    case
        when s.avg_gap_days is null then 'single'
        when s.avg_gap_days <= 30 then 'fast'
        else 'slow'
    end as pace
from all_customers c
left join stats s
    on s.customer_id = c.customer_id
order by c.customer_id;
