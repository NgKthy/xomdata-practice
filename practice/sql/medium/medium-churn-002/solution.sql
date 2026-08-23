-- Xom Data · Thuê bao còn hiệu lực hay đã dừng
-- Problem: https://xomdata.com/practice/medium-churn-002
-- Solved: 2026-08-23

select sub_id, customer_id,
    case
        when end_date is null or end_date >= '2024-06-30' then 'active'
        else 'stopped'
    end as status
from subscriptions;
