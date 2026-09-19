-- Xom Data · Top 3 campaigns by month-over-month growth
-- Problem: https://xomdata.com/practice/nightmare-pipeline-001
-- Solved: 2026-09-19

with dedup as (
    select campaign_id, spend_date, max(amount) as amount
    from campaign_spend
    group by campaign_id, spend_date
),
monthly as (
    select campaign_id,
        strftime('%Y-%m', spend_date) as month,
        sum(amount) as total_spend
    from dedup
    group by campaign_id, month
),
with_prev as (
    select m.campaign_id, m.month, m.total_spend,
        p.total_spend as prev_spend
    from monthly m
    left join monthly p
        on p.campaign_id = m.campaign_id
       and p.month = strftime('%Y-%m', date(m.month || '-01', '-1 month'))
),
growth as (
    select campaign_id, month, total_spend,
        round(
            case
                when prev_spend > 0 then (total_spend - prev_spend) * 100.0 / prev_spend
                else null
            end,
            2
        ) as growth_pct
    from with_prev
    where prev_spend > 0
),
ranked as (
    select month, campaign_id, total_spend, growth_pct,
        dense_rank() over (
            partition by month
            order by growth_pct desc, campaign_id
        ) as rank_in_month
    from growth
)
select month, campaign_id, total_spend, growth_pct, rank_in_month
from ranked
where rank_in_month <= 3
order by month, rank_in_month;
