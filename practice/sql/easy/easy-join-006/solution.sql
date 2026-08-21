-- Xom Data · Customers who ever bought skincare
-- Problem: https://xomdata.com/practice/easy-join-006
-- Solved: 2026-08-21

-- Viết SQL của bạn ở đây
select distinct c.customer_name
from customers c
join purchases p on p.customer_id = c.id
where category = 'Skincare';
