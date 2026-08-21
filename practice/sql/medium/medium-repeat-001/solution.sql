-- Xom Data · Khách một lần ghé và khách quay lại
-- Problem: https://xomdata.com/practice/medium-repeat-001
-- Solved: 2026-08-21

select customer_type, count(*) as customer_count
from (
    select customer_id,
        case 
            when count(order_id) = 1 then 'one-time'
            else 'repeat'
        end as customer_type
    from orders
    group by customer_id
)
group by customer_type;
