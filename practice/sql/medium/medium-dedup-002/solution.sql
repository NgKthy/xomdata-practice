-- Xom Data · The current price of each product
-- Problem: https://xomdata.com/practice/medium-dedup-002
-- Solved: 2026-10-16

-- Write your SQL here
with ranked as (
    select product_name, price, effective_date,
        row_number() over (
            partition by product_name
            order by effective_date desc
        ) as rn
    from price_history
)
select product_name, price, effective_date
from ranked
where rn = 1
order by product_name;
