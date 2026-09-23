-- Xom Data · Raw material cost of finished goods (multi-level BoM)
-- Problem: https://xomdata.com/practice/expert-final-rec-003
-- Solved: 2026-09-23

with recursive bom as (
    select p.id as product_id, p.id as node, 1 as qty
    from products p
    where p.id not in (select material_id from ingredients)
    union all
    select b.product_id, i.material_id, b.qty * i.quantity
    from bom b
    join ingredients i on i.product_id = b.node
)
select b.product_id, p.name,
    sum(b.qty * p2.selling_price) as total_cost
from bom b
join products p on p.id = b.product_id
join products p2 on p2.id = b.node
where b.node not in (select product_id from ingredients)
group by b.product_id, p.name
order by b.product_id;
