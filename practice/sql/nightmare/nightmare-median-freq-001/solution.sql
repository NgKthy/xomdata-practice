-- Xom Data · Median from a frequency distribution
-- Problem: https://xomdata.com/practice/nightmare-median-freq-001
-- Solved: 2026-10-27

with valid as (
    select number, frequency
    from numbers
    where frequency > 0
),
total as (
    select sum(frequency)::numeric as n
    from valid
),
cum as (
    select number, frequency,
        sum(frequency) over (
            order by number asc
        ) as cum_freq,
        coalesce(
            sum(frequency) over (
                order by number asc
                rows between unbounded preceding and 1 preceding
            ),
            0
        ) as prev_cum
    from valid
),
positions as (
    select n,
        case
            when mod(n, 2) = 1 then (n + 1) / 2
            else n / 2
        end as p1,
        case
            when mod(n, 2) = 1 then (n + 1) / 2
            else n / 2 + 1
        end as p2
    from total
),
m1 as (
    select c.number
    from cum c
    cross join positions p
    where c.cum_freq >= p.p1
      and c.prev_cum < p.p1
),
m2 as (
    select c.number
    from cum c
    cross join positions p
    where c.cum_freq >= p.p2
      and c.prev_cum < p.p2
)
select
    (m1.number + m2.number) / 2.0 as median
from m1
cross join m2;
