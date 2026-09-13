-- Xom Data · Time-weighted average price
-- Problem: https://xomdata.com/practice/nightmare-twa-001
-- Solved: 2026-09-13

with price_diffs as (
    select ticker, price,
        julianday(lead(valid_from) over (
            partition by ticker
            order by valid_from
        )) - julianday(valid_from) as days
    from price_states
)
select ticker, round(sum(price * days) / sum(days), 4) as twa
from price_diffs
where days is not null
group by ticker
order by ticker;
