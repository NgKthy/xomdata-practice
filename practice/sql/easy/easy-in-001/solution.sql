-- Xom Data · Customers in key cities
-- Problem: https://xomdata.com/practice/easy-in-001
-- Solved: 2026-08-22

-- Viết SQL của bạn ở đây
select customer_name, city
from customers
where city in ('Hanoi', 'Da Nang', 'Ho Chi Minh City')
