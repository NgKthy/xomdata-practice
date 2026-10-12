-- Xom Data · Trend labels for the monthly report
-- Problem: https://xomdata.com/practice/medium-lag-004
-- Solved: 2026-10-12

-- Write your SQL here
select month, revenue,
    case
        when lag(revenue) over (order by month) is null then 'First'
        when revenue > lag(revenue) over (order by month) then 'Up'
        when revenue < lag(revenue) over (order by month) then 'Down'
        else 'Flat'
    end as trend
from monthly_revenue
order by month;
