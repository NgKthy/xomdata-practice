-- Xom Data · Basic-plan subscribers
-- Problem: https://xomdata.com/practice/easy-like-001
-- Solved: 2026-08-19

select phone_number, full_name, plans
from subscribers
where plans like '%basic%'
order by full_name;
