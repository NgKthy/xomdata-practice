-- Xom Data · Optimal product selection within a weight limit (0/1 knapsack)
-- Problem: https://xomdata.com/practice/nightmare-knapsack-001
-- Solved: 2026-09-19

with recursive items_ordered as (
    select id, name, weight, value,
        row_number() over (order by id) as rn
    from items
),
n as (
    select count(*) as cnt from items
),
cap as (
    select capacity from constraints
),
subsets as (
    select 0 as rn, 0 as mask,
        0 as total_weight, 0 as total_value,
        '' as selected_names
    union all
    select s.rn + 1, s.mask | (1 << (i.rn - 1)),
        s.total_weight + i.weight,
        s.total_value + i.value,
        case
            when s.selected_names = '' then i.name
            else s.selected_names || ', ' || i.name
        end
    from subsets s
    join items_ordered i
        on i.rn = s.rn + 1
    where s.rn < (select cnt from n)
    union all
    select s.rn + 1, s.mask, s.total_weight,
        s.total_value, s.selected_names
    from subsets s
    where s.rn < (select cnt from n)
)
select total_value as best_value,
    total_weight as used_weight,
    selected_names as selected_items
from subsets
where total_weight <= (select capacity from cap)
order by total_value desc, mask asc
limit 1;
