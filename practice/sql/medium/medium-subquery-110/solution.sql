-- Xom Data · Employees paid above their department average
-- Problem: https://xomdata.com/practice/medium-subquery-110
-- Solved: 2026-08-24

with dept_avg as(
    select department_id, round(avg(salary), 0) as dept_avg_salary
    from employees
    group by department_id
)
select e.full_name, d.dept_name, e.salary, da.dept_avg_salary,
    round((e.salary - da.dept_avg_salary) * 100.0 / da.dept_avg_salary, 2) as premium_pct
from employees e
join departments d on e.department_id = d.id
join dept_avg da on e.department_id = da.department_id
where e.salary > da.dept_avg_salary
order by premium_pct desc, d.dept_name, e.full_name;
