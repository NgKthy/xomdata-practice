-- Xom Data · Rainwater trapped between concrete columns
-- Problem: https://xomdata.com/practice/nightmare-trapwater-001
-- Solved: 2026-09-15

with bounds as (
    select x, height, 
        max(height) over (
            order by x
            rows between unbounded preceding and current row
        ) as max_left,
        max(height) over (
            order by x
            rows between current row and unbounded following
        ) as max_right
    from bars
)
select sum (
    case
        when min(max_left, max_right) > height
        then min(max_left, max_right) - height
        else 0
    end
) as total_water
from bounds;
