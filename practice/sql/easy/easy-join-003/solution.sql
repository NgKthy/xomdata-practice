-- Xom Data · Line totals from the price list
-- Problem: https://xomdata.com/practice/easy-join-003
-- Solved: 2026-08-21

-- Viết SQL của bạn ở đây
select p.product_name, s.quantity, p.price * s.quantity as line_total
from sale_items s
join products p on s.product_id = p.id;
