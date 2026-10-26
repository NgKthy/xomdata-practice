-- Xom Data · 3-month rolling payroll (excluding each employee's latest month)
-- Problem: https://xomdata.com/practice/nightmare-cumulative-salary-001
-- Solved: 2026-10-26

with filtered as (
    select id, month, salary
    from employee e
    where month < (
        select max(month)
        from employee e2
        where e2.id = e.id
    )
)
select id, month,
    sum(salary) over (
        partition by id
        order by month asc
        rows between 2 preceding and current row
    ) as salary
from filtered
order by id, month desc;
