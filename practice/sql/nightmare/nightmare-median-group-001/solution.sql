-- Xom Data · Median department salary
-- Problem: https://xomdata.com/practice/nightmare-median-group-001
-- Solved: 2026-09-13

with ranked as (
    select department, salary,
        row_number() over (
            partition by department
            order by salary
        ) as rn,
        count(*) over (
            partition by department
        ) as cnt
    from employees
)
select department, round(avg(salary), 2) as median_salary
from ranked
where rn in (
    (cnt + 1) / 2,
    (cnt + 2) / 2
)
group by department
order by department;
