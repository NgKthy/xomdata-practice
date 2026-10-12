-- Xom Data · Class fund running total by day
-- Problem: https://xomdata.com/practice/medium-runtotal-001
-- Solved: 2026-10-12

select collect_date, amount,
    sum(amount) over (order by collect_date) as running_total
from fund_log
order by collect_date;
