-- Xom Data · Sales rank within each region
-- Problem: https://xomdata.com/practice/medium-rank-002
-- Solved: 2026-10-20

-- Write your SQL here
select region,
    rank() over (
        partition by region
        order by sales_amount desc
    ) as region_rank,
    rep_name,
    sales_amount
from reps
order by region, region_rank, rep_name;
