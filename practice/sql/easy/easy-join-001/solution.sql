-- Xom Data · Orders with customer names
-- Problem: https://xomdata.com/practice/easy-join-001
-- Solved: 2026-08-22

-- Viết SQL của bạn ở đây
select o.order_code, c.customer_name, o.amount
from customers c
join orders o on o.customer_id = c.id;
