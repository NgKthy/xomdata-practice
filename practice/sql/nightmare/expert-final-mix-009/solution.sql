-- Xom Data · Three-level sales totals: detail, by region, company-wide
-- Problem: https://xomdata.com/practice/expert-final-mix-009
-- Solved: 2026-09-30

select region, room, total_sales
from (
    select
        region,
        room,
        sum(revenue) as total_sales
    from sales
    group by region, room

    union all

    select
        region,
        null as room,
        sum(revenue) as total_sales
    from sales
    group by region

    union all

    select
        null as region,
        null as room,
        sum(revenue) as total_sales
    from sales
)
order by
    case when region is null then 1 else 0 end,
    region asc,
    case when room is null then 1 else 0 end,
    room asc;
