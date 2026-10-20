-- Xom Data · The customer's total next to every order
-- Problem: https://xomdata.com/practice/medium-winjoin-002
-- Solved: 2026-10-20

-- Write your SQL here
select c.customer_name, o.order_date, o.amount,
    sum(o.amount) over (
        partition by o.customer_id
    ) as customer_total
from orders o
join customers c
    on c.id = o.customer_id
order by c.customer_name, o.order_date;
