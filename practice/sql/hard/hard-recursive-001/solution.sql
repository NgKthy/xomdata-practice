-- Xom Data · Total payroll by org branch
-- Problem: https://xomdata.com/practice/hard-recursive-001
-- Solved: 2026-09-08

with recursive subtree as (
    select id, manager_id, salary, id as root_id
    from employees
    union all
    select e.id, e.manager_id, e.salary, s.root_id
    from employees e
    join subtree s on e.manager_id = s.id
),
direct_counts as (
    select manager_id, count(*) as direct_reports
    from employees
    where manager_id is not null
    group by manager_id
)
select
    s.root_id as manager_id,
    e.name as manager_name,
    coalesce(dc.direct_reports, 0) as direct_reports,
    count(distinct s.id) as subtree_size,
    sum(s.salary) as subtree_salary
from subtree s
join employees e on e.id = s.root_id
left join direct_counts dc on dc.manager_id = s.root_id
group by s.root_id, e.name, dc.direct_reports
having coalesce(dc.direct_reports, 0) > 0
order by subtree_salary desc, manager_id;
