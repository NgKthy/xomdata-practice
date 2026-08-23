-- Xom Data · Quy mô và tiền tươi tháng đầu của mỗi thế hệ
-- Problem: https://xomdata.com/practice/medium-cohort-008
-- Solved: 2026-08-23

with first_orders as(
    select customer_id,
        min(order_date) as first_date
    from orders
    group by customer_id
)
select substr(f.first_date, 1, 7) as cohort_month,
    count(distinct f.customer_id) as cohort_size,
    sum(o.amount) as first_month_revenue
from first_orders f
join orders o on f.customer_id = o.customer_id
where substr(o.order_date, 1, 7) = substr(f.first_date, 1, 7)
group by cohort_month
order by cohort_month;
