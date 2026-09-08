-- Xom Data · Revenue pivoted by product type
-- Problem: https://xomdata.com/practice/hard-pivot-001
-- Solved: 2026-09-08

select strftime('%Y-%m', sale_date) as month,
    coalesce(sum(case when category = 'Electronics' then amount end), 0) as electronics,
    coalesce(sum(case when category = 'Clothing' then amount end), 0) as clothing,
    coalesce(sum(case when category = 'Food' then amount end), 0) as food,
    SUM(amount) as total
from sales
group by month
order by month;
