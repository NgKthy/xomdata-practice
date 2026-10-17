-- Xom Data · Top 3 salaries per department
-- Problem: https://xomdata.com/practice/nightmare-top3-dept-001
-- Solved: 2026-10-17

with ranked as (
    select d.name as "Department",
        e.name as "Employee",
        e.salary as "Salary",
        dense_rank() over (
            partition by e.departmentid
            order by e.salary desc
        ) as rnk
    from employee e
    join department d
        on d.id = e.departmentid
)
select "Department",
    "Employee",
    "Salary"
from ranked
where rnk <= 3
order by "Department", "Salary" desc, "Employee";
