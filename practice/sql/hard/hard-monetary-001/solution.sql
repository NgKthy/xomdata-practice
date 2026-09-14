-- Xom Data · Chia khách thành năm hạng chi tiêu
-- Problem: https://xomdata.com/practice/hard-monetary-001
-- Solved: 2026-09-14

with customer_totals as (
    select customer_id, sum(amount) as total_spent
    from orders
    group by customer_id
),
ranked as (
    select customer_id, total_spent,
    ntile(5) over (
        order by total_spent desc, customer_id
    ) as spend_rank
    from customer_totals
)
select customer_id, total_spent, spend_rank
from ranked
order by spend_rank, customer_id;
