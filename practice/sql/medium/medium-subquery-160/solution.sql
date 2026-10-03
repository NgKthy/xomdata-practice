-- Xom Data · Low-activity users
-- Problem: https://xomdata.com/practice/medium-subquery-160
-- Solved: 2026-10-03

with user_totals as (
    select u.id, u.user_name,
        count(o.id) as order_count,
        sum(o.value) as total_value,
        avg(o.value) as avg_order_value
    from users u
    left join orders o on o.user_id = u.id
    group by u.id, u.user_name
),
overall_avg as (
    select avg(coalesce(total_value, 0)) as avg_total
    from user_totals
),
tiers as (
    select ut.*,
        case
            when ut.order_count = 0 then 'Inactive'
            when ut.total_value < (select avg_total from overall_avg) then 'Low'
            else 'Normal'
        end as tier
    from user_totals ut
)
select user_name, order_count, total_value, avg_order_value,
    tier,
    rank() over (
        order by
            case when total_value is null then 0 else 1 end,
            total_value asc
    ) as activity_rank,
    round(
        case
            when count(*) over () = 1 then 0
            else (rank() over (
                    order by
                        case when total_value is null then 0 else 1 end,
                        total_value asc
                 ) - 1) * 100.0 / (count(*) over () - 1)
        end,
        2
    ) as pct_above_peers
from tiers
where tier in ('Inactive', 'Low')
order by activity_rank, user_name;
