-- Xom Data · Sales division employees
-- Problem: https://xomdata.com/practice/easy-like-002
-- Solved: 2026-08-28

-- Viết SQL của bạn ở đây
select employee_code, full_name
from employees
where employee_code like 'SAL-%'
