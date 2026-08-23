-- Xom Data · Bao lâu thì khách quyết định quay lại lần hai
-- Problem: https://xomdata.com/practice/medium-gap-002
-- Solved: 2026-08-23

with ranked as(
    select customer_id, order_date, order_id,
        row_number() over(
            partition by customer_id
            order by order_date, order_id
        ) as rn
    from orders
)
select a.customer_id, 
    a.order_date as first_order_date, 
    b.order_date as second_order_date,
    cast(julianday(b.order_date) - julianday(a.order_date) as integer) as days_between
from ranked a
join ranked b
    on a.customer_id = b.customer_id
    and a.rn = 1 and b.rn = 2
order by days_between asc, a.customer_id asc;
