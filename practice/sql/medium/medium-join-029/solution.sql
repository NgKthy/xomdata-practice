-- Xom Data · Instructor teaching load
-- Problem: https://xomdata.com/practice/medium-join-029
-- Solved: 2026-09-19

with counts as (
    select l.id, l.full_name, l.academic_degree,
        count(s.id) as subjects_taught
    from lecturers l
    left join subjects s 
        on s.lecturer_id = l.id
    group by l.id, l.full_name, l.academic_degree
)
select full_name, academic_degree, subjects_taught,
    rank() over (order by subjects_taught desc) as workload_rank,
    sum(subjects_taught) over (order by subjects_taught desc, full_name) as cumulative_subjects
from counts
order by workload_rank, full_name;
