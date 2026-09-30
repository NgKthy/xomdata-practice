-- Xom Data · Median salary per department
-- Problem: https://xomdata.com/practice/sql-nightmare-002
-- Solved: 2026-09-30

with ranked as (
    select dept, salary,
        row_number() over (partition by dept order by salary) as rn,
        count(*) over (partition by dept) as cnt
    from employees
)
select dept, avg(salary) as median_salary
from ranked
where rn in ((cnt + 1) / 2, (cnt + 2) / 2)
group by dept
order by dept;
