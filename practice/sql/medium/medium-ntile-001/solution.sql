-- Xom Data · Splitting customers into four spending tiers
-- Problem: https://xomdata.com/practice/medium-ntile-001
-- Solved: 2026-10-18

-- Write your SQL here
with ranked as (
    select customer_name, total_spent,
        ntile(4) over (
            order by total_spent desc, customer_name
        ) as spend_quartile
    from customer_spending
)
select customer_name, total_spent, spend_quartile
from ranked
order by spend_quartile, total_spent desc, customer_name;
