-- Xom Data · Salary by department and title
-- Problem: https://xomdata.com/practice/medium-join-126
-- Solved: 2026-10-17

with dept_position_salary as (
    select d.department_name, p.position_name,
        count(e.id) as employee_count,
        avg(pr.net_salary) as avg_salary,
        min(pr.net_salary) as min_salary,
        max(pr.net_salary) as max_salary,
        max(pr.net_salary) - min(pr.net_salary) as salary_spread
    from employees e
    join departments d on d.id = e.department_id
    join positions p on p.id = e.position_id
    join payroll pr on pr.employee_id = e.id
    group by d.id, d.department_name, p.id, p.position_name
)
select department_name, position_name, employee_count,
    avg_salary, min_salary, max_salary, salary_spread,
    rank() over (
        partition by department_name
        order by avg_salary desc
    ) as rank_in_dept
from dept_position_salary
order by department_name, rank_in_dept, position_name;
