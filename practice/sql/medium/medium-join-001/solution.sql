-- Xom Data · Customer spending per order
-- Problem: https://xomdata.com/practice/medium-join-001
-- Solved: 2026-09-06

with customer_stats as (
    select c.id, c.full_name,
        count(o.id) as order_count,
        coalesce(sum(o.total_amount), 0) as total_spending,
        coalesce(round(avg(o.total_amount), 0), 0) as avg_order_value
    from customers c
    left join orders o on c.id = o.customer_id
    group by c.id, c.full_name
)
select full_name, order_count, total_spending, avg_order_value,
    row_number() over (
        order by total_spending desc, full_name) as spending_rank
from customer_stats
order by spending_rank;
