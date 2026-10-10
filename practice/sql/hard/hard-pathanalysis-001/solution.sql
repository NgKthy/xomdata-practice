-- Xom Data · Most common 3-step user path
-- Problem: https://xomdata.com/practice/hard-pathanalysis-001
-- Solved: 2026-10-10

with ordered as (
    select user_id, page,
        lead(page, 1) over (
            partition by user_id
            order by viewed_at
        ) as page2,
        lead(page, 2) over (
            partition by user_id
            order by viewed_at
        ) as page3
    from page_views
)
select page || ' > ' || page2 || ' > ' || page3 as path,
    count(distinct user_id) as n_users
from ordered
where page2 is not null
  and page3 is not null
group by path
order by n_users desc, path
limit 10;
