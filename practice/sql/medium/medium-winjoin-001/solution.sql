-- Xom Data · Sales rankings with department names
-- Problem: https://xomdata.com/practice/medium-winjoin-001
-- Solved: 2026-10-13

-- Write your SQL here
select d.dept_name,
    rank() over (
        partition by s.dept_id
        order by s.sales_amount desc
    ) as dept_rank,
    s.staff_name,
    s.sales_amount
from staff s
join departments d
    on d.id = s.dept_id
order by d.dept_name, dept_rank, s.staff_name;
