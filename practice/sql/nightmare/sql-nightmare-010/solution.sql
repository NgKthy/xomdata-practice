-- Xom Data · TWAP per stock symbol
-- Problem: https://xomdata.com/practice/sql-nightmare-010
-- Solved: 2026-09-23

with ticks as (
    select symbol, tick_time, price,
        lead(tick_time) over (
            partition by symbol
            order by tick_time
        ) as next_time
    from price_ticks
),
weighted as (
    select symbol, price,
        (julianday(next_time) - julianday(tick_time)) * 24.0 as duration
    from ticks
    where next_time is not null
)
select symbol,
    round(sum(price * duration) / sum(duration), 4) as twap
from weighted
group by symbol
order by symbol;
