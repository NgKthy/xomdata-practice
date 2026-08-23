-- Xom Data · So găng lượng khách giữa các quý
-- Problem: https://xomdata.com/practice/medium-active-006
-- Solved: 2026-08-23

with quarterly_data as(
    select substr(order_date, 1, 4) || '-Q' ||
    case
        when cast(substr(order_date, 6, 2) as integer) between 1 and 3 then '1'
        when cast(substr(order_date, 6, 2) as integer) between 4 and 6 then '2'
        when cast(substr(order_date, 6, 2) as integer) between 7 and 9 then '3'
        else '4'
    end as quarter, customer_id
    from orders
), 
quarterly_counts as(
    select quarter, count(distinct customer_id) as active_customers
    from quarterly_data
    group by quarter
)
select quarter, active_customers, 
    active_customers - lag(active_customers, 1) over (order by quarter) as change_vs_prev
from quarterly_counts
order by quarter;
