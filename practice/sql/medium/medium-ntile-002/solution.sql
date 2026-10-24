-- Xom Data · Splitting deliveries into three shifts by order time
-- Problem: https://xomdata.com/practice/medium-ntile-002
-- Solved: 2026-10-24

-- Write your SQL here
select order_code, order_time,
    ntile(3) over (
        order by order_time, order_code 
    ) as delivery_shift
from morning_orders
order by delivery_shift, order_time, order_code;
