-- Xom Data · Top salary in each department
-- Problem: https://xomdata.com/practice/easy-groupby-005
-- Solved: 2026-08-25

-- Viết SQL của bạn ở đây
select department, max(salary) as top_salary
from employees
group by department
order by department;
