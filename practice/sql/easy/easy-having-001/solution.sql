-- Xom Data · Categories full enough for the homepage
-- Problem: https://xomdata.com/practice/easy-having-001
-- Solved: 2026-08-22

-- Viết SQL của bạn ở đây
select category, count(*) as num_products
from products
group by category
having count(*) >= 3
order by category;
