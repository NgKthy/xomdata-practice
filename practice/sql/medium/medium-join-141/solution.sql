-- Xom Data · Consultation revenue by doctor
-- Problem: https://xomdata.com/practice/medium-join-141
-- Solved: 2026-10-13

with stats as (
    select f.faculty_name,
        d.full_name as doctor_name,
        count(mv.id) as visit_count,
        avg(mv.visit_fee) as avg_exam_fee,
        sum(mv.visit_fee) as total_exam_fee,
        d.faculty_id
    from doctors d
    join faculties f on f.id = d.faculty_id
    left join medical_visits mv on mv.doctor_id = d.id
    group by d.id, d.full_name, f.faculty_name, d.faculty_id
)
select faculty_name, doctor_name, visit_count, avg_exam_fee, total_exam_fee,
    rank() over (order by total_exam_fee desc) as overall_rank,
    dense_rank() over (partition by faculty_id order by total_exam_fee desc) as rank_in_faculty
from stats
order by total_exam_fee desc, doctor_name 
limit 15;
