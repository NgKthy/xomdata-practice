-- Xom Data · Detect anomalous days vs the average
-- Problem: https://xomdata.com/practice/hard-anomaly-001
-- Solved: 2026-10-10

with mean_calc as (
    select avg(value) as mean
    from daily_metrics
),
std_calc as (
    select sqrt(avg((value - m.mean) * (value - m.mean))) as stddev
    from daily_metrics, mean_calc m
)
select date, value,
    round(m.mean, 2) as mean,
    round(s.stddev, 2) as stddev,
    case
        when s.stddev = 0 then 0
        else round((value - m.mean) / s.stddev, 2)
    end as z_score,
    case
        when s.stddev = 0 then 'normal'
        when (value - m.mean) / s.stddev > 2 then 'high'
        when (value - m.mean) / s.stddev < -2 then 'low'
        else 'normal'
    end as flag
from daily_metrics, mean_calc m, std_calc s
order by date;
