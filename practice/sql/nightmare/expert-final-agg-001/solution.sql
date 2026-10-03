-- Xom Data · Quarterly sales per employee (2024)
-- Problem: https://xomdata.com/practice/expert-final-agg-001
-- Solved: 2026-10-03

select employee_id,
    sum(case when quarter = 1 then revenue else 0 end) as q1,
    sum(case when quarter = 2 then revenue else 0 end) as q2,
    sum(case when quarter = 3 then revenue else 0 end) as q3,
    sum(case when quarter = 4 then revenue else 0 end) as q4
from sales
where year = 2024
group by employee_id
order by employee_id;
