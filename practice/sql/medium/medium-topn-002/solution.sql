-- Xom Data · Top three sellers per category
-- Problem: https://xomdata.com/practice/medium-topn-002
-- Solved: 2026-09-13

-- Write your SQL here
with ranked as (
    select category, product_name, units_sold,
        row_number() over (
            partition by category
            order by units_sold desc, product_name
        ) as rn
    from menu_sales
)
select category, product_name, units_sold
from ranked
where rn <= 3
order by category, units_sold desc, product_name;
