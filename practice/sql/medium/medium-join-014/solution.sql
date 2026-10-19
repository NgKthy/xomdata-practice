-- Xom Data · Stock-in history by supplier
-- Problem: https://xomdata.com/practice/medium-join-014
-- Solved: 2026-10-19

with warehouse_stats as (
    select w.id, w.warehouse_name,
        count(si.id) as import_count,
        count(distinct si.product_id) as distinct_product_count,
        count(distinct si.suppliers) as distinct_supplier_count,
        max(si.import_date) as last_import_date
    from warehouses w
    left join stock_imports si
        on si.warehouse_id = w.id
    group by w.id, w.warehouse_name
),
ranked as (
    select *,
        rank() over (order by import_count desc) as activity_rank
    from warehouse_stats
)
select warehouse_name, import_count, distinct_product_count,
    distinct_supplier_count, last_import_date, activity_rank,
    lag(warehouse_name) over (
        order by activity_rank, warehouse_name 
    ) as prev_warehouse
from ranked
order by activity_rank, warehouse_name;
