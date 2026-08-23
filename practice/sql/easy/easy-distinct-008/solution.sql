-- Xom Data · Countries our students come from
-- Problem: https://xomdata.com/practice/easy-distinct-008
-- Solved: 2026-08-23

-- Viết SQL của bạn ở đây
select count(*) as num_countries
from (
    select distinct country
    from students
);
