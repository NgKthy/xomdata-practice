-- Xom Data · Total spend for one budget category
-- Problem: https://xomdata.com/practice/easy-sum-005
-- Solved: 2026-09-22

-- Write your SQL here
select coalesce(sum(amount), 0) as total_spent
from expenses
where category = 'Marketing';
