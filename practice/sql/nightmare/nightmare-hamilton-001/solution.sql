-- Xom Data · Route visiting every location exactly once
-- Problem: https://xomdata.com/practice/nightmare-hamilton-001
-- Solved: 2026-09-27

with recursive
nodes as (
    select u as node from edges
    union
    select v from edges
),
n as (
    select count(*) as cnt from nodes
),
paths as (
    select node as current,
        cast(node as text) as path_str,
        ',' || node || ',' as visited,
        1 as depth
    from nodes
    union all
    select e.v, p.path_str || '->' || cast(e.v as text),
        p.visited || e.v || ',', p.depth + 1
    from paths p
    join edges e
        on e.u = p.current
    where p.depth < (select cnt from n)
      and instr(p.visited, ',' || e.v || ',') = 0
)
select
    case
        when exists (
            select 1 from paths
            where depth = (select cnt from n)
        ) then 1
        else 0
    end as has_path,
    (
        select path_str
        from paths
        where depth = (select cnt from n)
        order by path_str asc
        limit 1
    ) as first_path;
