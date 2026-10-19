-- Xom Data · Opening order or returning order
-- Problem: https://xomdata.com/practice/medium-cohort-002
-- Solved: 2026-10-19

-- Write your SQL here
select customer_name, order_date, amount,
    case
        when row_number() over (
            partition by customer_name
            order by order_date 
        ) = 1 then 'New'
        else 'Returning'
    end as order_type
from orders
order by customer_name, order_date;
