-- Xom Data · Shortest steps to each node from node 1
-- Problem: https://xomdata.com/practice/expert-final-graph-009
-- Solved: 2026-10-03

with recursive paths as (
    select 1 as current,
        '1' as path_str,
        ',' || 1 || ',' as visited,
        0 as hops
    union all
    select l.destination,
        p.path_str || '->' || l.destination,
        p.visited || l.destination || ',',
        p.hops + 1
    from paths p
    join links l on l.source = p.current
    where p.visited not like '%,' || l.destination || ',%'
),
min_hops as (
    select current as destination,
        min(hops) as min_hops
    from paths
    where current != 1
    group by current
)
select p.current as destination,
    p.hops as min_hops,
    p.path_str as path
from paths p
join min_hops m
    on m.destination = p.current
   and m.min_hops = p.hops
where p.current != 1
order by p.hops, p.current, p.path_str;
