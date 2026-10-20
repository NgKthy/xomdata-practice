-- Xom Data · Each customer's cumulative spending
-- Problem: https://xomdata.com/practice/medium-runtotal-002
-- Solved: 2026-10-20

-- Write your SQL here
select customer_name, month, spend,
    sum(spend) over (
        partition by customer_name
        order by month
        rows between unbounded preceding and current row
    ) as cumulative_spend
from wallet_monthly
order by customer_name, month;
