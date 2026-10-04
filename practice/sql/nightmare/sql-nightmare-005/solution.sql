-- Xom Data · Employee levels in the org chart
-- Problem: https://xomdata.com/practice/sql-nightmare-005
-- Solved: 2026-10-04

with recursive org as (
    select id, name, 1 as depth
    from employees
    where manager_id is null
    union all
    select e.id, e.name, o.depth + 1
    from employees e
    join org o
        on e.manager_id = o.id
)
select id, name, depth
from org
order by id;
