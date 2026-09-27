-- Xom Data · Minimum-cost delivery route
-- Problem: https://xomdata.com/practice/nightmare-tsp-001
-- Solved: 2026-09-27

with recursive
nodes as (
    select u as node from edges
    union
    select v from edges
),
start_node as (
    select min(node) as start from nodes
),
total as (
    select count(*) as n from nodes
),
edge_min as (
    select u, v, min(cost) as cost
    from edges
    group by u, v
),
tours as (
    select e.u as current,
        ',' || e.u || ',' as visited,
        0 as total_cost, 1 as depth,
        (select start from start_node) as start
    from edge_min e
    where e.u = (select start from start_node)
    union all
    select e.v, t.visited || e.v || ',',
        t.total_cost + e.cost, t.depth + 1, t.start
    from tours t
    join edge_min e on e.u = t.current
    where t.depth < (select n from total)
      and instr(t.visited, ',' || e.v || ',') = 0
)
select coalesce(
    (select min(t.total_cost + e.cost)
     from tours t
     join edge_min e on e.u = t.current and e.v = t.start
     where t.depth = (select n from total)),
    case when (select n from total) = 1 then 0 else null end
) as min_tour_cost;
