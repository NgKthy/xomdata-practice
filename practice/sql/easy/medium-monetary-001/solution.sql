-- Xom Data · Ai đã tiêu vượt mốc năm triệu
-- Problem: https://xomdata.com/practice/medium-monetary-001
-- Solved: 2026-09-22

select
    customer_id,
    sum(amount) as total_spent,
    case
        when sum(amount) >= 5000000 then 'VIP'
        else 'Standard'
    end as segment
from orders
group by customer_id
order by customer_id asc;
