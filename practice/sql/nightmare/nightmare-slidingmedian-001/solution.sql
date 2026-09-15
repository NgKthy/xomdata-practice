-- Xom Data · Centered 5-session rolling median price per session
-- Problem: https://xomdata.com/practice/nightmare-slidingmedian-001
-- Solved: 2026-09-15

with windows as (
    select p.day as day, q.price as price,
        row_number() over (
            partition by p.day
            order by q.price, q.day
        ) as rn,
        count(*) over (
            partition by p.day
        ) as cnt
    from prices p
    join prices q
        on q.day between p.day - 2 and p.day + 2
)
select day,
    round(
        case
            when cnt % 2 = 1 
            then max(case when rn = (cnt + 1) / 2 then price end)
            else (max(case when rn = cnt / 2 then price end) + max(case when rn = cnt / 2 + 1 then price end)) / 2.0
        end, 2
    ) as median_price
from windows
group by day
order by day;
