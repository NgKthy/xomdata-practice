-- Xom Data · Tam giác giữ chân dạng sổ cái
-- Problem: https://xomdata.com/practice/hard-retention-006
-- Solved: 2026-10-04

with first_order as (
    select customer_id,
        min(strftime('%Y-%m', order_date)) as cohort_month
    from orders
    group by customer_id
),
customer_months as (
    select distinct customer_id,
        strftime('%Y-%m', order_date) as order_month
    from orders
),
cohort_size as (
    select cohort_month,
        count(*) as cohort_size
    from first_order
    group by cohort_month
),
ledger as (
    select f.cohort_month,
        (
            (cast(substr(cm.order_month, 1, 4) as integer) - cast(substr(f.cohort_month, 1, 4) as integer)) * 12
            + (cast(substr(cm.order_month, 6, 2) as integer) - cast(substr(f.cohort_month, 6, 2) as integer))
        ) as month_age,
        cm.customer_id
    from customer_months cm
    join first_order f on f.customer_id = cm.customer_id
)
select l.cohort_month, l.month_age, cs.cohort_size,
    count(distinct l.customer_id) as retained,
    round(100.0 * count(distinct l.customer_id) / cs.cohort_size, 2) as retention_pct
from ledger l
join cohort_size cs on cs.cohort_month = l.cohort_month
group by l.cohort_month, l.month_age, cs.cohort_size
order by l.cohort_month, l.month_age;
