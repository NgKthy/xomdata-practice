-- Xom Data · Khách chuyên cần đủ bốn mùa
-- Problem: https://xomdata.com/practice/medium-repeat-006
-- Solved: 2026-08-23

with orders_2024 as(
    select customer_id, order_date, amount,
        case
            when cast(substr(order_date, 6,2) as integer) between 1 and 3 then 1
            when cast(substr(order_date, 6,2) as integer) between 4 and 6 then 2
            when cast(substr(order_date, 6,2) as integer) between 7 and 9 then 3
            when cast(substr(order_date, 6,2) as integer) between 10 and 12 then 4
        end as quarter
    from orders
    where substr(order_date, 1, 4) = '2024'
)
select customer_id, count(*) as orders_2024
from orders_2024
group by customer_id
having count(distinct quarter) = 4;
