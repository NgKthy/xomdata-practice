-- Xom Data · Monthly recurring revenue (MRR) by subscription plan
-- Problem: https://xomdata.com/practice/hard-mrr-001
-- Solved: 2026-09-25

with recursive
bounds as (
    select min(started_at) as min_start,
        max(started_at) as max_start
    from subscriptions
),
months as (
    select strftime('%Y-%m', min_start) as month
    from bounds
    union all
    select strftime('%Y-%m', date(month || '-01', '+1 month'))
    from months
    where month < (select strftime('%Y-%m', max_start) from bounds)
)
select m.month,
    count(s.user_id) as active_subs,
    coalesce(sum(s.mrr), 0) as total_mrr
from months m
left join subscriptions s
    on s.started_at <= date(m.month || '-01', '+1 month', '-1 day')
   and (s.ended_at is null or s.ended_at > date(m.month || '-01', '+1 month', '-1 day'))
group by m.month
order by m.month;
