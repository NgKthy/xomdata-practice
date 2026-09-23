-- Xom Data · Điểm tươi mới cộng điểm chuyên cần
-- Problem: https://xomdata.com/practice/hard-rfm-003
-- Solved: 2026-09-23

with customer_stats as (
    select customer_id,
        max(order_date) as last_order_date,
        count(*) as order_count
    from orders
    where order_date <= '2024-06-30'
    group by customer_id
),
scored as (
    select customer_id,
        6 - ntile(5) over (
            order by last_order_date desc, customer_id asc
        ) as r_score,
        case
            when order_count >= 8 then 3
            when order_count >= 4 then 2
            else 1
        end as f_score
    from customer_stats
)
select customer_id, r_score, f_score,
    r_score + f_score as total_score,
    case
        when r_score + f_score >= 7 then 'Gold'
        when r_score + f_score >= 5 then 'Silver'
        else 'Bronze'
    end as label
from scored;
