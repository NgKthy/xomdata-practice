-- Xom Data · Conversion rate through a 4-step purchase funnel
-- Problem: https://xomdata.com/practice/sql-nightmare-009
-- Solved: 2026-10-28

with step_order as (
    values
        ('visit', 1),
        ('cart', 2),
        ('checkout', 3),
        ('payment', 4)
),
step_counts as (
    select so.column1 as step,
        so.column2 as ord,
        count(distinct fe.user_id) as users
    from step_order so
    left join funnel_events fe
        on fe.event = so.column1
    group by so.column1, so.column2
),
calculated as (
    select step, ord, users,
        round(
            users * 100.0 / nullif(
                max(case when step = 'visit' then users end) over (),
                0
            ),
            2
        ) as pct_of_total,
        round(
            users * 100.0 / nullif(
                lag(users) over (order by ord),
                0
            ),
            2
        ) as pct_of_prev
    from step_counts
)
select step, users, pct_of_total, pct_of_prev
from calculated
order by ord;
