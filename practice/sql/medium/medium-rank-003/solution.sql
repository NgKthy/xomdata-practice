-- Xom Data · Revenue rank of each category
-- Problem: https://xomdata.com/practice/medium-rank-003
-- Solved: 2026-10-20

-- Write your SQL here
with category_totals as (
    select category,
        sum(amount) as total_revenue
    from sales
    group by category
)
select category, total_revenue,
    rank() over (order by total_revenue desc) as revenue_rank
from category_totals
order by revenue_rank, category;
