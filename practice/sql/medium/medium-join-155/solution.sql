-- Xom Data · Rank hotels by room price within each destination
-- Problem: https://xomdata.com/practice/medium-join-155
-- Solved: 2026-10-16

with hotel_stats as (
    select h.id as hotel_id,
        h.hotel_name,
        h.star_class,
        d.id as destination_id,
        d.destination_name,
        count(hr.id) as room_count,
        min(hr.nightly_rate) as min_price,
        max(hr.nightly_rate) as max_price,
        avg(hr.nightly_rate) as avg_price,
        max(hr.nightly_rate) - min(hr.nightly_rate) as price_spread
    from hotels h
    join destinations d on d.id = h.destination_id
    join hotel_rooms hr on hr.hotel_id = h.id
    group by h.id, h.hotel_name, h.star_class, d.id, d.destination_name
    having count(hr.id) >= 2
)
select hotel_name, star_class, destination_name, room_count,
    min_price, max_price, avg_price, price_spread,
    rank() over (
        partition by destination_id
        order by avg_price desc
    ) as rank_in_destination
from hotel_stats
order by destination_name, rank_in_destination, hotel_name;
