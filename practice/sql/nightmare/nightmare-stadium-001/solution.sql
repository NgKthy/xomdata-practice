-- Xom Data · Stadium high-attendance streaks (3+ consecutive days ≥ 100)
-- Problem: https://xomdata.com/practice/nightmare-stadium-001
-- Solved: 2026-10-25

with hot as (
    select id, visit_date, people
    from stadium
    where people >= 100
),
numbered as (
    select id, visit_date, people,
        id - row_number() over (order by id) as grp
    from hot
),
streaks as (
    select id, visit_date, people, grp,
        count(*) over (partition by grp) as streak_len
    from numbered
)
select id, visit_date, people
from streaks
where streak_len >= 3
order by visit_date;
