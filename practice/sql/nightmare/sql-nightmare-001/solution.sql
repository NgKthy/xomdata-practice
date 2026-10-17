-- Xom Data · Longest consecutive login streak
-- Problem: https://xomdata.com/practice/sql-nightmare-001
-- Solved: 2026-10-17

with distinct_dates as (
    select distinct user_id,
        login_date::date as login_date
    from logins
),
numbered as (
    select user_id, login_date,
        row_number() over (
            partition by user_id
            order by login_date
        ) as rn
    from distinct_dates
),
grouped as (
    select user_id,
        login_date - rn::int as grp
    from numbered
),
streaks as (
    select user_id, grp,
        count(*) as streak_len
    from grouped
    group by user_id, grp
)
select user_id,
    max(streak_len) as max_streak
from streaks
group by user_id
order by user_id;
