-- Xom Data · YoY and QoQ sales growth
-- Problem: https://xomdata.com/practice/hard-yoy-001
-- Solved: 2026-09-08

with lagged as (
    select year, quarter, revenue,
        lag(revenue, 1) over (order by year, quarter) as prev_quarter_revenue,
        lag(revenue, 4) over (order by year, quarter) as prev_year_revenue
    from quarterly_sales
)
select year, quarter, revenue, prev_quarter_revenue, prev_year_revenue,
    case 
        when prev_quarter_revenue is not null and prev_quarter_revenue != 0 
        then round((revenue - prev_quarter_revenue) * 100.0 / prev_quarter_revenue, 2)
        else null
    end as qoq_pct,
    case
        when prev_year_revenue is not null and prev_year_revenue != 0 
        then round((revenue - prev_year_revenue) * 100.0 / prev_year_revenue, 2)
        else null
    end as yoy_pct
from lagged
order by year, quarter;
