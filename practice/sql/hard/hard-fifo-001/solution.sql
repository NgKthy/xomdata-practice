-- Xom Data · Running inventory balance over time
-- Problem: https://xomdata.com/practice/hard-fifo-001
-- Solved: 2026-10-13

select sku, occurred_at, type, quantity,
    sum(
        case
            when type = 'IN' then quantity
            when type = 'OUT' then -quantity
            else 0
        end
    ) over (
        partition by sku
        order by occurred_at, id
    ) as running_balance
from inventory_movements
order by sku, occurred_at, id;
