-- Xom Data · Multi-level profit margin analysis
-- Problem: https://xomdata.com/practice/hard-multicte-001
-- Solved: 2026-09-08

with product_aggregates as (
    select p.id, p.name as product_name, p.category, p.unit_cost,
        sum(o.quantity * o.price) as revenue, 
        sum(o.quantity * p.unit_cost) as cost,
        sum(o.quantity * o.price) - sum(o.quantity * p.unit_cost) as profit
    from products p
    join orders o on p.id = o.product_id
    group by p.id, p.name, p.category, p.unit_cost
),
ranked as (
    select category, product_name, revenue, cost, profit,
        round(100.0 * profit / revenue, 2) as margin_pct,
        dense_rank() over (partition by category
                            order by profit desc) as rank_in_cat,
        max(profit) over (partition by category) as max_profit_in_cat
    from product_aggregates
)
select category, product_name, revenue, cost, profit, margin_pct, rank_in_cat,
    round(100.0 * profit / max_profit_in_cat, 2) as pct_of_top_in_cat
from ranked
order by category, rank_in_cat, product_name;
