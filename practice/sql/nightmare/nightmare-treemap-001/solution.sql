-- Xom Data · Treemap layout: split a 1000×1000 canvas by value ratio
-- Problem: https://xomdata.com/practice/nightmare-treemap-001
-- Solved: 2026-09-19

with recursive layout as (
    select id, parent_id, name, value,
        0 as depth, 0.0 as x, 0.0 as y,
        1000.0 as w, 1000.0 as h
    from categories
    where parent_id is null
    union all
    select c.id, c.parent_id, c.name,
        c.value, p.depth + 1,
        case
            when p.depth % 2 = 0 then
                p.x + p.w * (
                    select coalesce(sum(s.value), 0)
                    from categories s
                    where s.parent_id = c.parent_id
                      and (
                          s.value > c.value
                          or (s.value = c.value and s.id < c.id)
                      )
                ) / p.value
            else p.x
        end,
        case
            when p.depth % 2 = 1 then
                p.y + p.h * (
                    select coalesce(sum(s.value), 0)
                    from categories s
                    where s.parent_id = c.parent_id
                      and (
                          s.value > c.value
                          or (s.value = c.value and s.id < c.id)
                      )
                ) / p.value
            else p.y
        end,
        case
            when p.depth % 2 = 0 then p.w * c.value / p.value
            else p.w
        end,
        case
            when p.depth % 2 = 1 then p.h * c.value / p.value
            else p.h
        end
    from categories c
    join layout p
        on c.parent_id = p.id
)
select id, name,
    round(x, 2) as x,
    round(y, 2) as y,
    round(w, 2) as w,
    round(h, 2) as h
from layout
order by id;
