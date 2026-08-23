-- Xom Data · Doanh thu đội nón ra đi cùng khách cũ
-- Problem: https://xomdata.com/practice/medium-churn-007
-- Solved: 2026-08-23

select customer_id, 
    max(order_date) as last_order_date,
    sum(amount) as lost_revenue
from orders
group by customer_id
having julianday('2024-06-30') - julianday(max(order_date)) > 90
order by lost_revenue desc, customer_id asc;
