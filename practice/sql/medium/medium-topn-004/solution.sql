-- Xom Data · Each branch's two slowest months
-- Problem: https://xomdata.com/practice/medium-topn-004
-- Solved: 2026-09-13

-- Write your SQL here
with ranked as (
    select branch, month, revenue,
        row_number() over (
            partition by branch
            order by revenue, month
        ) as rn
    from branch_monthly
)
select branch, month, revenue
from ranked
where rn <= 2
order by branch, revenue, month;
