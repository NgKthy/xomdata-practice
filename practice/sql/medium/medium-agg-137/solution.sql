-- Xom Data · Investor trade summary
-- Problem: https://xomdata.com/practice/medium-agg-137
-- Solved: 2026-10-12

with summary as (
    select i.id, i.full_name, i.segment,
        count(t.id) as total_trades,
        sum(case when t.side = 'buy' then t.amount else 0 end) as total_bought,
        sum(case when t.side = 'sell' then t.amount else 0 end) as total_sold
    from investors i
    join trades t
        on t.investor_id = i.id
    group by i.id, i.full_name, i.segment
)
select full_name, segment, total_trades, total_bought, total_sold,
    total_bought - total_sold as net_position,
    case
        when total_bought > total_sold then 'Bull'
        when total_bought < total_sold then 'Bear'
        else 'Neutral'
    end as stance,
    dense_rank() over (
        partition by segment
        order by (total_bought + total_sold) desc
    ) as rank_in_segment
from summary
order by (total_bought + total_sold) desc, full_name;
