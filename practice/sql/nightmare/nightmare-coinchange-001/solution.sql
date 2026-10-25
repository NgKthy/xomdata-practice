-- Xom Data · Minimum coins to make the target amount (unlimited denominations)
-- Problem: https://xomdata.com/practice/nightmare-coinchange-001
-- Solved: 2026-10-25

with recursive coin_values as (
    select distinct value
    from coins
    where value > 0
),
reach as (
    select 0 as amount, 0 as coin_count
    union
    select
        r.amount + c.value,
        r.coin_count + 1
    from reach r
    join coin_values c
        on r.amount + c.value <= (select max(amount) from target)
    where r.amount < (select max(amount) from target)
)
select
    t.amount as target,
    coalesce(min(r.coin_count), -1) as min_coins
from target t
left join reach r
    on r.amount = t.amount
group by t.amount;
