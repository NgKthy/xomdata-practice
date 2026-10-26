-- Xom Data · Who is still on an active streak today
-- Problem: https://xomdata.com/practice/hard-streak-002
-- Solved: 2026-10-26

with recursive customer_months as (
    select distinct customer_id,
        date_trunc('month', order_date::date)::date as month_start
    from orders
),
june_customers as (
    select customer_id
    from customer_months
    where month_start = date '2024-06-01'
),
streaks as (
    select customer_id,
        date '2024-06-01' as month_start,
        1 as current_streak
    from june_customers
    union all
    select s.customer_id,
        (s.month_start - interval '1 month')::date as month_start,
        s.current_streak + 1
    from streaks s
    join customer_months cm
        on cm.customer_id = s.customer_id
       and cm.month_start = (s.month_start - interval '1 month')::date
)
select customer_id,
    max(current_streak) as current_streak
from streaks
group by customer_id
order by current_streak desc, customer_id;
