-- Xom Data · Each category's slice of revenue
-- Problem: https://xomdata.com/practice/medium-winagg-009
-- Solved: 2026-10-17

-- Write your SQL here
with category_totals as (
    select category, sum(amount) as total_revenue
    from sales
    group by category
),
grand_total as (
    select sum(total_revenue) as total
    from category_totals
)
select ct.category, ct.total_revenue,
    round(ct.total_revenue * 100.0 / gt.total, 2) as pct_share
from category_totals ct
cross join grand_total gt
order by ct.total_revenue desc, ct.category;
