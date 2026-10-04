-- Xom Data · Frequently co-purchased product pairs
-- Problem: https://xomdata.com/practice/sql-nightmare-004
-- Solved: 2026-10-04

with user_products as (
    select distinct user_id, product_id
    from orders
)
select up1.product_id as product_a,
    up2.product_id as product_b,
    count(distinct up1.user_id) as co_buyers
from user_products up1
join user_products up2
    on up1.user_id = up2.user_id
   and up1.product_id < up2.product_id
group by up1.product_id, up2.product_id
order by co_buyers desc, product_a, product_b;
