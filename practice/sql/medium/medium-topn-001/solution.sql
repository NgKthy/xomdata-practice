-- Xom Data · Sales champion of each region
-- Problem: https://xomdata.com/practice/medium-topn-001
-- Solved: 2026-09-13

-- Write your SQL here
with ranked as (
    select region, rep_name, sales_amount,
        row_number() over (
            partition by region
            order by sales_amount desc, rep_name
        ) as rn
    from reps
)
select region, rep_name, sales_amount
from ranked
where rn = 1
order by region;
