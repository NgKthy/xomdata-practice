-- Xom Data · Average score per subject
-- Problem: https://xomdata.com/practice/medium-groupby-027
-- Solved: 2026-09-07

with subject_stats as (
    select s.id, s.subject_name, s.credits, 
        count (g.id) as student_count,
        round(avg(g.final_score), 2) as avg_score,
        round(100.0 * sum(case 
                            when g.final_score >= 5 then 1
                            else 0
                        end) / count(g.id), 2) as pass_rate
    from subjects s
    join grades g on s.id = g.subject_id
    group by s.id, s.subject_name, s.credits
)
select subject_name, credits, student_count, avg_score, pass_rate,
    rank() over (order by avg_score desc) as rank_by_avg,
    ntile(4) over (order by avg_score desc, subject_name) as difficulty_quartile
from subject_stats
order by rank_by_avg, subject_name;
