-- Xom Data · Classify products by sales velocity
-- Problem: https://xomdata.com/practice/medium-case-110
-- Solved: 2026-09-25

with product_sales as (
    select p.id, p.name, p.categories,
        coalesce(sum(t.quantity), 0) as total_sold
    from products p
    left join transactions t
        on t.product_id = p.id
    group by p.id, p.name, p.categories
),
cat_totals as (
    select categories,
        sum(total_sold) as cat_total
    from product_sales
    group by categories
)
select ps.name, ps.categories, ps.total_sold,
    case
        when ps.total_sold >= 100 then 'Best Seller'
        when ps.total_sold >= 50 then 'Average'
        else 'Slow Mover'
    end as classification,
    dense_rank() over (
        partition by ps.categories
        order by ps.total_sold desc
    ) as rank_in_cat,
    case
        when ct.cat_total = 0 then 0
        else round(ps.total_sold * 100.0 / ct.cat_total, 2)
    end as pct_of_cat_total
from product_sales ps
join cat_totals ct
    on ct.categories = ps.categories
order by ps.categories, rank_in_cat, ps.name;
