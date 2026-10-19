-- Xom Data · Price tiers for rooms on sale
-- Problem: https://xomdata.com/practice/medium-denserank-001
-- Solved: 2026-10-19

-- Write your SQL here
with ranked as (
    select room_no, price,
        dense_rank() over (
            order by price desc
        ) as price_tier
    from rooms
)
select room_no, price, price_tier
from ranked
order by price_tier, room_no;
