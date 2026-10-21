-- Xom Data · Category price range next to each item
-- Problem: https://xomdata.com/practice/medium-winagg-008
-- Solved: 2026-10-21

-- Write your SQL here
select category, product_name, price,
    min(price) over (partition by category) as cat_min,
    max(price) over (partition by category) as cat_max
from products
order by category, price, product_name;
