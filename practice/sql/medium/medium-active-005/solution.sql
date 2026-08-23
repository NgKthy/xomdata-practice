-- Xom Data · Đà tăng giảm lượng khách qua từng tháng
-- Problem: https://xomdata.com/practice/medium-active-005
-- Solved: 2026-08-23

with monthly as(
    select substr(order_date, 1, 7) as month,
        count(distinct customer_id) as active_customers
    from orders
    group by month
)
select month, active_customers,
    active_customers - lag(active_customers, 1) over (order by month) as change_vs_prev
from monthly
order by month asc;
