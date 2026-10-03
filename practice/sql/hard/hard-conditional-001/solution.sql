-- Xom Data · Cumulative revenue from successful transactions only
-- Problem: https://xomdata.com/practice/hard-conditional-001
-- Solved: 2026-10-03

select date, status, amount,
    sum(
        case when status = 'success' then amount else 0 end
    ) over (
        order by date, status, id 
        rows between unbounded preceding and current row
    ) as running_success_total
from transactions
order by date, status, id;
