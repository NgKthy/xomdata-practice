-- Xom Data · Product share within its store
-- Problem: https://xomdata.com/practice/medium-winagg-002
-- Solved: 2026-10-23

-- Write your SQL here
select store, product, amount,
    round(amount * 100.0 / sum(amount) over (partition by store), 2) as pct_of_store
from store_sales
order by store, product;
