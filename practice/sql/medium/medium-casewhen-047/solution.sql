-- Xom Data · Portfolio profit/loss
-- Problem: https://xomdata.com/practice/medium-casewhen-047
-- Solved: 2026-09-19

with calc as (
    select s.stock_code, c.stock_quantity, c.avg_cost_price, s.current_price,
        (s.current_price - c.avg_cost_price) * c.stock_quantity as profit_loss_raw,
        ((s.current_price - c.avg_cost_price) / c.avg_cost_price) * 100 as profit_pct_raw,
        c.avg_cost_price * c.stock_quantity as invested
    from categories c
    join stocks s on s.id = c.stock_id
),
ranked as (
    select *,
        round(profit_loss_raw, 0) as profit_loss,
        round(profit_pct_raw, 2) as profit_pct,
        case
            when profit_pct_raw > 10 then 'Strong Gain'
            when profit_pct_raw > 0 then 'Mild Gain'
            when profit_pct_raw = 0 then 'Break Even'
            when profit_pct_raw > -10 then 'Mild Loss'
            else 'Strong Loss'
        end as status,
        rank() over (order by profit_pct_raw desc) as rank_by_pct,
        sum(invested) over (order by profit_pct_raw desc, stock_code 
                            rows between unbounded preceding and current row) as cumulative_invested
    from calc
)
select stock_code, stock_quantity, avg_cost_price, current_price,
    profit_loss, profit_pct, status, rank_by_pct, cumulative_invested
from ranked
order by rank_by_pct, stock_code;
