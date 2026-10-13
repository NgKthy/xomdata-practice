-- Xom Data · The eight-segment customer map
-- Problem: https://xomdata.com/practice/hard-rfm-006
-- Solved: 2026-10-13

with stats as (
    select customer_id,
        max(order_date) as last_order,
        count(*) as order_count
    from orders
    where order_date <= '2024-06-30'
    group by customer_id
),
scored as (
    select customer_id,
        case
            when julianday('2024-06-30') - julianday(last_order) <= 30 then 4
            when julianday('2024-06-30') - julianday(last_order) <= 60 then 3
            when julianday('2024-06-30') - julianday(last_order) <= 120 then 2
            else 1
        end as r_score,
        case
            when order_count >= 10 then 4
            when order_count >= 5 then 3
            when order_count >= 2 then 2
            else 1
        end as f_score
    from stats
)
select customer_id, r_score, f_score,
    case
        when r_score >= 3 and f_score >= 3 then 'Champions'
        when r_score >= 3 and f_score = 2 then 'Potential Loyalist'
        when r_score >= 3 and f_score = 1 then 'New Customers'
        when r_score = 2 and f_score >= 3 then 'At Risk'
        when r_score = 2 and f_score <= 2 then 'About To Sleep'
        when r_score = 1 and f_score >= 3 then 'Cannot Lose Them'
        when r_score = 1 and f_score = 2 then 'Hibernating'
        when r_score = 1 and f_score = 1 then 'Lost'
    end as segment
from scored;
