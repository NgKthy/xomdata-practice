-- Xom Data · Cumulative revenue and cumulative % of the period total
-- Problem: https://xomdata.com/practice/expert-final-win-008
-- Solved: 2026-09-23

with period_totals as (
    select period,
        sum(revenue) as period_revenue
    from sales
    group by period
),
running as (
    select period, period_revenue,
        sum(period_revenue) over (order by period) as running_total,
        sum(period_revenue) over () as grand_total
    from period_totals
)
select period, period_revenue, running_total, grand_total,
    round(running_total * 100.0 / grand_total, 1) as cumulative_pct
from running
order by period;
