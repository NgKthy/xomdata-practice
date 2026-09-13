-- Xom Data · Shift bonus for every top performer
-- Problem: https://xomdata.com/practice/medium-topn-003
-- Solved: 2026-09-13

-- Write your SQL here
with ranked as (
    select store, staff_name, orders_served,
        rank() over (
            partition by store
            order by orders_served desc
        ) as rnk
    from shift_stats
)
select store, staff_name, orders_served
from ranked
where rnk = 1
order by store, staff_name;
