-- Xom Data · Each aisle's best seller
-- Problem: https://xomdata.com/practice/medium-winjoin-003
-- Solved: 2026-10-19

-- Write your SQL here
with ranked as (
    select c.category_name, p.product_name, p.units_sold,
        row_number() over (
            partition by c.id
            order by p.units_sold desc, p.product_name 
        ) as rn
    from categories c
    join products p
        on p.category_id = c.id
)
select category_name, product_name, units_sold
from ranked
where rn = 1
order by category_name;
