-- Xom Data · Revenue by product category
-- Problem: https://xomdata.com/practice/easy-groupby-002
-- Solved: 2026-08-23

-- Viết SQL của bạn ở đây
select category, sum(amount) as total_revenue
from sales
group by category
order by category;
