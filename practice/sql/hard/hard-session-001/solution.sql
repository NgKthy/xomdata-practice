-- Xom Data · Sessionize logins with a 30-minute gap
-- Problem: https://xomdata.com/practice/hard-session-001
-- Solved: 2026-09-08

with numbered as (
    select user_id, event_at,
        lag(event_at) over (partition by user_id
                            order by event_at) as prev_event_at
    from events
),
session_groups as (
    select user_id, event_at,
        sum(case
                when prev_event_at is null
                    or (julianday(event_at) - julianday(prev_event_at)) * 1440 > 30
                then 1
                else 0
            end) over (partition by user_id
                        order by event_at) as session_id
    from numbered
)
select user_id,
    dense_rank() over (partition by user_id 
                        order by session_id) as session_seq,
    count(*) as n_events,
    min(event_at) as session_start,
    max(event_at) as session_end,
    round((julianday(max(event_at)) - julianday(min(event_at))) * 1440, 1) as duration_min
from session_groups
group by user_id, session_id
order by user_id, session_seq;
