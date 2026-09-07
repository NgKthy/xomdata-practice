-- Xom Data · Classify student academic performance
-- Problem: https://xomdata.com/practice/medium-case-124
-- Solved: 2026-09-07

select full_name, student_code, avg_score,
    case
        when avg_score >= 9 then 'Excellent'
        when avg_score >= 8 then 'Good'
        when avg_score >= 7 then 'Fair'
        when avg_score >= 5 then 'Average'
        else 'Poor'
    end as grade,
    class_rank
from (
    select s.full_name, s.student_code,
        round(avg(sc.final_score), 2) as avg_score,
        dense_rank() over (order by avg(sc.final_score) desc) as class_rank
    from students s
    JOIN scores sc on s.id = sc.student_id
    group by s.id, s.full_name, s.student_code
)
order by avg_score desc, student_code
limit 20;
