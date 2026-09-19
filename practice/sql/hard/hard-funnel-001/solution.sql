-- Xom Data · 4-step onboarding conversion rate
-- Problem: https://xomdata.com/practice/hard-funnel-001
-- Solved: 2026-09-19

with step_order as (
    select 'signup' as step, 1 as ord
    union all
    select 'verify_email', 2
    union all
    select 'first_login', 3
    union all
    select 'first_purchase', 4
),
step_counts as (
    select so.step, so.ord,
        count(distinct e.user_id) as n_users
    from step_order so
    left join events e
        on e.event_name = so.step
    group by so.step, so.ord
),
signup_total as (
    select coalesce(max(n_users), 0) as total
    from step_counts
    where step = 'signup'
)
select sc.step, sc.n_users,
    coalesce(round(100.0 * sc.n_users / nullif((select total from signup_total), 0), 2), 0) as conversion_pct
from step_counts sc
order by sc.ord;
