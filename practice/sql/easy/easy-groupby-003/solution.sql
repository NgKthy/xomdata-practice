-- Xom Data · Average score per class
-- Problem: https://xomdata.com/practice/easy-groupby-003
-- Solved: 2026-08-23

-- Viết SQL của bạn ở đây
select class_name, round(avg(score), 2) as avg_score
from scores
group by class_name
order by class_name;
