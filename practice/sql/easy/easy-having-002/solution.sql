-- Xom Data · Customers reaching the loyalty milestone
-- Problem: https://xomdata.com/practice/easy-having-002
-- Solved: 2026-08-22

-- Viết SQL của bạn ở đây
select customer_name, sum(amount) as total_spent
from purchases
group by customer_name
having sum(amount) >= 5000000
order by total_spent desc, customer_name;
