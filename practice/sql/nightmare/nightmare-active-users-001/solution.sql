-- Xom Data · Users active 5+ consecutive days
-- Problem: https://xomdata.com/practice/nightmare-active-users-001
-- Solved: 2026-09-25

with distinct_days as (
    select distinct id, login_date
    from logins
),
numbered as (
    select id, login_date,
        row_number() over (
            partition by id
            order by login_date
        ) as rn
    from distinct_days
),
streaks as (
    select id, count(*) as cnt
    from numbered
    group by id, julianday(login_date) - rn
)
select distinct id
from streaks
where cnt >= 5
order by id;
