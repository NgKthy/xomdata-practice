-- Xom Data · Quý khởi đầu của mỗi khách
-- Problem: https://xomdata.com/practice/medium-cohort-005
-- Solved: 2026-08-23

with first_order as(
    select customer_id, min(order_date) as first_date
    from orders
    group by customer_id
)
select customer_id,
    substr(first_date, 1, 4) || '-Q' ||
        case
            when cast(substr(first_date, 6, 2) as integer) between 1 and 3 then '1'
            when cast(substr(first_date, 6, 2) as integer) between 4 and 6 then '2'
            when cast(substr(first_date, 6, 2) as integer) between 7 and 9 then '3'
            else '4'
        end as first_quarter
from first_order;
