-- Xom Data · Longest run of consecutive active months
-- Problem: https://xomdata.com/practice/hard-streak-001
-- Solved: 2026-10-25

with months as (
    select distinct customer_id,
        date_trunc('month', order_date::date)::date as month_start
    from orders
),
numbered as (
    select customer_id, month_start,
        row_number() over (
            partition by customer_id
            order by month_start asc
        ) as rn,
        (
            extract(year from month_start)::int * 12
            + extract(month from month_start)::int
        ) as month_num
    from months
),
grouped as (
    select customer_id,
        month_num - rn as grp,
        count(*) as streak_len
    from numbered
    group by customer_id, month_num - rn
)
select customer_id,
    max(streak_len) as longest_streak
from grouped
group by customer_id
order by longest_streak desc, customer_id;
