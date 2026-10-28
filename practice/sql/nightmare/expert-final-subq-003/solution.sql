-- Xom Data · Second-highest-paid employee per department
-- Problem: https://xomdata.com/practice/expert-final-subq-003
-- Solved: 2026-10-28

with ranked as (
    select department, full_name, salary,
        dense_rank() over (
            partition by department
            order by salary desc
        ) as salary_rank
    from employees
)
select department, full_name, salary
from ranked
where salary_rank = 2
order by department, full_name;
