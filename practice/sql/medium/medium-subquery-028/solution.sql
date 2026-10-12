-- Xom Data · Students above the subject average
-- Problem: https://xomdata.com/practice/medium-subquery-028
-- Solved: 2026-10-12

with subject_stats as (
    select subject_id,
        avg(final_score) as avg_score
    from grades
    group by subject_id
)
select s.full_name, sub.subject_name, g.final_score,
    round(ss.avg_score, 2) as subject_avg,
    round(g.final_score - ss.avg_score, 2) as diff_from_avg
from grades g
join students s on s.id = g.student_id
join subjects sub on sub.id = g.subject_id
join subject_stats ss on ss.subject_id = g.subject_id
where g.final_score > ss.avg_score
order by diff_from_avg desc, sub.subject_name, s.full_name;
