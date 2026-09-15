-- Xom Data · Largest rectangle in histogram
-- Problem: https://xomdata.com/practice/nightmare-histogram-001
-- Solved: 2026-09-15

with intervals as (
    select b1.pos as l, b2.pos as r
    from bars b1
    join bars b2 on b1.pos <= b2.pos
),
areas as (
    select (i.r - i.l + 1) * min(b.height) as area
    from intervals i
    join bars b on b.pos between i.l and i.r
    group by i.l, i.r
)
select max(area) as max_area
from areas;
