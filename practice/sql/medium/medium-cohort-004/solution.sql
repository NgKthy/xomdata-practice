-- Xom Data · Mỗi thế hệ khách đông cỡ nào
-- Problem: https://xomdata.com/practice/medium-cohort-004
-- Solved: 2026-08-23

with first_order as(
    select customer_id, 
        min(order_date) as first_date
    from orders
    group by customer_id
)
select substr(first_date, 1, 7) as cohort_month,
    count(*) as cohort_size
from first_order
group by cohort_month
order by cohort_month asc;
