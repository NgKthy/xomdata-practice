-- Xom Data · Revenue split by new vs returning customers
-- Problem: https://xomdata.com/practice/sql-nightmare-006
-- Solved: 2026-10-27

with monthly as (
    select user_id, month,
        sum(revenue) as revenue
    from sales
    group by user_id, month
),
first_month as (
    select user_id,
        min(month) as first_month
    from monthly
    group by user_id
),
new_rev as (
    select m.month,
        sum(m.revenue) as new_revenue
    from monthly m
    join first_month f
        on f.user_id = m.user_id
       and f.first_month = m.month
    group by m.month
),
returning_rev as (
    select m.month,
        sum(m.revenue) as returning_revenue
    from monthly m
    join first_month f
        on f.user_id = m.user_id
       and f.first_month < m.month
    group by m.month
),
months as (
    select distinct month
    from sales
),
prev_map as (
    select month,
        to_char((month || '-01')::date - interval '1 month', 'YYYY-MM') as prev_month
    from months
),
churned as (
    select pm.month,
        coalesce(sum(pmrev.revenue), 0) as churned_revenue
    from prev_map pm
    left join monthly pmrev
        on pmrev.month = pm.prev_month
    left join monthly cur
        on cur.user_id = pmrev.user_id
       and cur.month = pm.month
    where cur.user_id is null
    group by pm.month
)
select m.month,
    coalesce(n.new_revenue, 0) as new_revenue,
    coalesce(r.returning_revenue, 0) as returning_revenue,
    coalesce(c.churned_revenue, 0) as churned_revenue
from months m
left join new_rev n
    on n.month = m.month
left join returning_rev r
    on r.month = m.month
left join churned c
    on c.month = m.month
order by m.month;
