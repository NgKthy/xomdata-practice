-- Xom Data · D7 and D30 retention rate
-- Problem: https://xomdata.com/practice/hard-retention-001
-- Solved: 2026-09-25

with d7 as (
    select distinct s.user_id
    from signups s
    join activity a
        on a.user_id = s.user_id
       and a.active_date between date(s.signup_date, '+1 day') and date(s.signup_date, '+7 day')
),
d30 as (
    select distinct s.user_id
    from signups s
    join activity a
        on a.user_id = s.user_id
       and a.active_date between date(s.signup_date, '+1 day') and date(s.signup_date, '+30 day')
),
tot as (
    select count(distinct user_id) as total_users
    from signups
)
select
    t.total_users,
    (select count(*) from d7) as d7_retained,
    coalesce(
        round(100.0 * (select count(*) from d7) / nullif(t.total_users, 0), 2),
        0
    ) as d7_rate,
    (select count(*) from d30) as d30_retained,
    coalesce(
        round(100.0 * (select count(*) from d30) / nullif(t.total_users, 0), 2),
        0
    ) as d30_rate
from tot t;
