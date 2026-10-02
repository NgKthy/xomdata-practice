-- Xom Data · Merge overlapping bookings into continuous ranges
-- Problem: https://xomdata.com/practice/nightmare-interval-merge-001
-- Solved: 2026-10-02

with ordered as (
    select room_id, start_at, end_at,
        max(end_at) over (
            partition by room_id
            order by start_at, end_at
            rows between unbounded preceding and 1 preceding
        ) as prev_max_end
    from bookings
),
grouped as (
    select room_id, start_at, end_at,
        sum(
            case
                when prev_max_end is null or start_at > prev_max_end then 1
                else 0
            end
        ) over (
            partition by room_id
            order by start_at, end_at
            rows between unbounded preceding and current row
        ) as grp
    from ordered
)
select room_id,
    min(start_at) as merged_start,
    max(end_at) as merged_end,
    count(*) as n_bookings,
    cast(
        round(
            (julianday(max(end_at)) - julianday(min(start_at))) * 1440
        ) as integer
    ) as duration_min
from grouped
group by room_id, grp
order by room_id, merged_start;
