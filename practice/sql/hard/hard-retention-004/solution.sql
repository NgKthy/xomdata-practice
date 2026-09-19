-- Xom Data · Ma trận tỷ lệ quay lại ba tháng đầu
-- Problem: https://xomdata.com/practice/hard-retention-004
-- Solved: 2026-09-19

with first_month as (
    select customer_id,
        min(strftime('%Y-%m', order_date)) as cohort_month
    from orders
    group by customer_id
),
cohort_size as (
    select cohort_month, count(*) as cohort_size
    from first_month
    group by cohort_month
),
activity as (
    select distinct customer_id,
        strftime('%Y-%m', order_date) as activity_month
    from orders
),
cohort_activity as (
    select fm.cohort_month, fm.customer_id, a.activity_month,
        (cast(substr(a.activity_month, 1, 4) as integer) - cast(substr(fm.cohort_month, 1, 4) as integer)) * 12 +
        (cast(substr(a.activity_month, 6, 2) as integer) - cast(substr(fm.cohort_month, 6, 2) as integer)) as month_offset
    from first_month fm
    join activity a
        on a.customer_id = fm.customer_id
)
select cs.cohort_month, cs.cohort_size,
    case
        when count(distinct case when ca.month_offset = 0 then ca.customer_id end) = 0 then 0
        else round(100.0 * count(distinct case when ca.month_offset = 0 then ca.customer_id end) / cs.cohort_size, 2)
    end as m0_pct,
    case
        when count(distinct case when ca.month_offset = 1 then ca.customer_id end) = 0 then 0
        else round(100.0 * count(distinct case when ca.month_offset = 1 then ca.customer_id end) / cs.cohort_size, 2)
    end as m1_pct,
    case
        when count(distinct case when ca.month_offset = 2 then ca.customer_id end) = 0 then 0
        else round(100.0 * count(distinct case when ca.month_offset = 2 then ca.customer_id end) / cs.cohort_size, 2)
    end as m2_pct
from cohort_size cs
left join cohort_activity ca
    on ca.cohort_month = cs.cohort_month
group by cs.cohort_month, cs.cohort_size
order by cs.cohort_month;
