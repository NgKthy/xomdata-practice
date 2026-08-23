-- Xom Data · Ai nhập hội đúng mùa khuyến mãi
-- Problem: https://xomdata.com/practice/medium-cohort-007
-- Solved: 2026-08-23

select customer_id,
    min(order_date) as first_order_date,
    count(case
            when substr(order_date, 1, 7) = '2024-03' then 1
        end) as campaign_orders
from orders
group by customer_id
having substr(min(order_date), 1, 7) = '2024-03';
