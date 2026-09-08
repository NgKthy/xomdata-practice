-- Xom Data · Median and percentile salary by department
-- Problem: https://xomdata.com/practice/hard-percentile-001
-- Solved: 2026-09-08

with ranked as (
    select department, salary, 
        row_number() over (partition by department
                            order by salary, id) as rn,
        count(*) over (partition by department) as cnt
    from employees
),
percentiles as (
    select department, salary,
        case
            when cnt = 1 then 0.0
            else (rn - 1) * 1.0 / (cnt - 1)
        end as pct_rank
    from ranked
),
targets as (
    select 0.25 as target
    union all
    select 0.50
    union all
    select 0.75
),
best as (
    select p.department, t.target, p.salary,
        row_number() over (partition by p.department, t.target
                            order by abs(p.pct_rank - t.target), p.salary) as rn_best
    from percentiles p
    cross join targets t
)
select department,
    max(case when target = 0.25 then salary end) as p25,
    max(case when target = 0.50 then salary end) as p50,
    max(case when target = 0.75 then salary end) as p75
from best
where rn_best = 1
group by department
order by department;
