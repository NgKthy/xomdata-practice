-- Xom Data · Advertiser status by month (4 states)
-- Problem: https://xomdata.com/practice/nightmare-statemachine-001
-- Solved: 2026-09-13

with recursive months as (
    select min(month) as month
    from advertiser_activity
    union all
    select strftime('%Y-%m', date(month || '-01', '+1 month'))
    from months
    where month < (select max(month) from advertiser_activity)
),
advertisers as (
    select distinct advertiser_id
    from advertiser_activity
),
grid as (
    select a.advertiser_id, m.month
    from advertisers a
    cross join months m
),
activity as (
    select g.advertiser_id, g.month,
        case when aa.advertiser_id is not null then 1 else 0 end as is_active
    from grid g
    left join advertiser_activity aa
        on aa.advertiser_id = g.advertiser_id
       and aa.month = g.month
),
with_prev as (
    select advertiser_id, month, is_active,
        lag(is_active, 1, 0) over (
            partition by advertiser_id
            order by month
        ) as prev_active,
        max(is_active) over (
            partition by advertiser_id
            order by month
            rows between unbounded preceding and 1 preceding
        ) as any_prior_active
    from activity
),
states as (
    select advertiser_id, month,
        case
            when is_active = 1 and coalesce(any_prior_active, 0) = 0 then 'NEW'
            when is_active = 1 and prev_active = 1 then 'EXISTING'
            when is_active = 1 then 'RESURRECT'
            when is_active = 0 and prev_active = 1 then 'CHURN'
            else null
        end as state
    from with_prev
)
select advertiser_id, month, state
from states
where state is not null
order by advertiser_id, month;
