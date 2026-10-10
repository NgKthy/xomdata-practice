-- Xom Data · Suppliers that deliver late frequently
-- Problem: https://xomdata.com/practice/medium-having-162
-- Solved: 2026-10-10

with supplier_stats as (
    select s.id, s.supplier_name, s.material_type,
        count(po.id) as purchase_count,
        sum(po.total_value) as total_purchase_value,
        round(avg(julianday(po.actual_receipt) - julianday(po.expected_receipt)), 2) as avg_late_days,
        round(
            100.0 * sum(
                case
                    when julianday(po.actual_receipt) <= julianday(po.expected_receipt) then 1
                    else 0
                end
            ) / count(po.id),
            2
        ) as on_time_rate
    from suppliers s
    join purchase_orders po
        on po.supplier_id = s.id
    group by s.id, s.supplier_name, s.material_type
    having count(po.id) >= 3
       and avg(julianday(po.actual_receipt) - julianday(po.expected_receipt)) > 0
),
ranked as (
    select *,
        rank() over (
            order by avg_late_days desc
        ) as late_rank,
        ntile(4) over (
            order by avg_late_days desc, supplier_name 
        ) as risk_tier
    from supplier_stats
)
select supplier_name, material_type, purchase_count, total_purchase_value,
    avg_late_days, on_time_rate, late_rank, risk_tier
from ranked
order by late_rank, supplier_name;
