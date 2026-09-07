-- Xom Data · High-rated sellers with many orders
-- Problem: https://xomdata.com/practice/medium-having-019
-- Solved: 2026-09-07

select s.store_name, s.reputation_score,
    count(o.id) as order_count,
    dense_rank() over (order by count(o.id) desc) as rank_by_orders,
    sum(COUNT(o.id)) over (order by count(o.id) desc, s.store_name) as cumulative_orders
from sellers s
join orders o on s.id = o.seller_id
where s.reputation_score >= 4.5
group by s.id, s.store_name, s.reputation_score
having count(o.id) >= 3
order by rank_by_orders, s.store_name;
