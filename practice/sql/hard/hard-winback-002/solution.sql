-- Xom Data · Counting comebacks each month
-- Problem: https://xomdata.com/practice/hard-winback-002
-- Solved: 2026-10-13

with customer_months as (
    select distinct customer_id,
        strftime('%Y-%m', order_date) as month
    from orders
),
with_prev as (
    select customer_id, month,
        lag(month) over (
            partition by customer_id
            order by month
        ) as prev_month
    from customer_months
)
select month,
    count(distinct customer_id) as resurrected_customers
from with_prev
where prev_month is not null
  and (
        (cast(substr(month, 1, 4) as integer) - cast(substr(prev_month, 1, 4) as integer)) * 12
        + (cast(substr(month, 6, 2) as integer) - cast(substr(prev_month, 6, 2) as integer))
      ) >= 3
group by month
order by month;
