-- Xom Data · Top 10 highest-profit dishes
-- Problem: https://xomdata.com/practice/medium-agg-147
-- Solved: 2026-10-12

with dish_stats as (
    select d.id, d.dish_name, c.category_name,
        sum(oi.quantity) as total_sold,
        sum(oi.quantity * oi.unit_price) as revenue,
        sum(oi.quantity * (oi.unit_price - d.cost_price)) as profit
    from order_items oi
    join orders o
        on o.id = oi.order_id
       and o.status = 'Completed'
    join dishes d
        on d.id = oi.dish_id
    join categories c
        on c.id = d.category_id
    group by d.id, d.dish_name, c.category_name
)
select dish_name, category_name, total_sold, revenue, profit,
    round(profit * 100.0 / revenue, 2) as margin_pct,
    rank() over (order by profit desc) as rank_by_profit,
    rank() over (order by profit * 100.0 / revenue desc) as rank_by_margin
from dish_stats
order by profit desc, dish_name 
limit 10;
