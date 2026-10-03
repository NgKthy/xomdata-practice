-- Xom Data · Chấm điểm công bằng khi nhiều khách ngang tài
-- Problem: https://xomdata.com/practice/hard-rfm-005
-- Solved: 2026-10-03

with totals as (
    select customer_id,
        sum(amount) as total_spent
    from orders
    group by customer_id
),
ranked as (
    select customer_id, total_spent,
        rank() over (order by total_spent desc) as rnk,
        count(*) over () as total_customers
    from totals
)
select customer_id, total_spent,
    case
        when total_customers = 1 then 5
        when (rnk - 1) * 1.0 / (total_customers - 1) < 0.2 then 5
        when (rnk - 1) * 1.0 / (total_customers - 1) < 0.4 then 4
        when (rnk - 1) * 1.0 / (total_customers - 1) < 0.6 then 3
        when (rnk - 1) * 1.0 / (total_customers - 1) < 0.8 then 2
        else 1
    end as m_score
from ranked;
