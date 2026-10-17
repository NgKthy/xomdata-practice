-- Xom Data · Total sales by org branch
-- Problem: https://xomdata.com/practice/hard-hierarchical-001
-- Solved: 2026-10-17

with recursive team_sales as (
    select id as root_id, id as member_id, direct_sales
    from agents
    union all
    select ts.root_id, a.id, a.direct_sales
    from team_sales ts
    join agents a
        on a.manager_id = ts.member_id
)
select a.id as agent_id, a.name as agent_name, a.direct_sales,
    sum(ts.direct_sales) as team_total
from agents a
join team_sales ts
    on ts.root_id = a.id
group by a.id, a.name, a.direct_sales
order by team_total desc, a.id;
