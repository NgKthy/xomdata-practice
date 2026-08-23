-- Xom Data · Bức ảnh tệp khách tại một thời điểm
-- Problem: https://xomdata.com/practice/medium-churn-006
-- Solved: 2026-08-23

with customer_stats as (
    select
        customer_id,
        min(order_date) as first_date,
        max(order_date) as last_date
    from orders
    group by customer_id
),
segmented as (
    select
        customer_id,
        case
            when SUBSTR(first_date, 1, 7) = '2024-06' then 'new'
            when cast(julianday('2024-06-30') - julianday(last_date) as integer) > 90 then 'churned'
            else 'active'
        end as segment
    from customer_stats
)
select
    segment,
    count(*) as customer_count
from segmented
group by segment;
