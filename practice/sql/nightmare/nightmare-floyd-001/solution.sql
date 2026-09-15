-- Xom Data · Shortest path between all node pairs (Floyd-Warshall)
-- Problem: https://xomdata.com/practice/nightmare-floyd-001
-- Solved: 2026-09-15

with recursive
nodes as (
    select u as node from edges
    union
    select v from edges
),
all_nodes as (
    select distinct node from nodes
),
paths as (
    select u as start, v as end, cost, 1 as depth
    from edges
    union all
    select p.start, e.v, p.cost + e.cost, p.depth + 1
    from paths p
    join edges e on p.end = e.u
    where p.depth < (select count(*) from all_nodes) - 1
)
select start as u, end as v,
    min(cost) as min_cost
from (
    select node as start, node as end, 0 as cost from all_nodes
    union all
    select start, end, cost from paths
)
group by start, end
order by u, v;
