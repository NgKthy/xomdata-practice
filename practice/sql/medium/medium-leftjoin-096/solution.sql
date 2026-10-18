-- Xom Data · Accounts with no posts
-- Problem: https://xomdata.com/practice/medium-leftjoin-096
-- Solved: 2026-10-18

with no_posts as (
    select u.id, u.full_name, u.username, u.account_type,
        cast(u.created_at as date) as signup_date
    from users u
    where not exists (
        select 1
        from posts p
        where p.user_id = u.id
    )
),
ranked as (
    select full_name, username, account_type,
        row_number() over (
            order by signup_date, username 
        ) as signup_order,
        ntile(4) over (
            order by signup_date, username 
        ) as tenure_quartile
    from no_posts
)
select full_name, username, account_type, signup_order, tenure_quartile
from ranked
order by signup_order;
