-- Xom Data · Next session with a higher price
-- Problem: https://xomdata.com/practice/nightmare-nextgreater-001
-- Solved: 2026-09-05

with next_days as (
    select day, price,
        (select min(day)
        from prices p2
        where p2.day > p1.day
        and p2.price > p1.price) as next_higher_day
    from prices p1
)
select day, price, next_higher_day,
    case
        when next_higher_day is not null
        then next_higher_day - day
        else null
    end as days_until
from next_days
order by day;
