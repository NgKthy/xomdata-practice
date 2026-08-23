-- Xom Data · Cửa hàng giữ được bao nhiêu phần khách
-- Problem: https://xomdata.com/practice/medium-repeat-002
-- Solved: 2026-08-23

select round(100.0 * count(case
                            when order_count >= 2 then 1
                        end) / count(*), 2) as repeat_rate_pct
from(
    select customer_id, count(*) as order_count
    from orders
    group by customer_id
);
