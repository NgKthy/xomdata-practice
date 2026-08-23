-- Xom Data · Nhịp khách ghé cửa hàng theo tháng
-- Problem: https://xomdata.com/practice/medium-active-001
-- Solved: 2026-08-23

select substr(order_date, 1, 7) as month,
    count(distinct customer_id) as active_customers
from orders
group by month
order by month asc;
