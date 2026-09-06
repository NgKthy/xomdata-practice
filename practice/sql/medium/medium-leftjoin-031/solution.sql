-- Xom Data · Candidates not yet interviewed
-- Problem: https://xomdata.com/practice/medium-leftjoin-031
-- Solved: 2026-09-06

with no_interview as (
    select c.id, c.full_name, c.email, c.application_date
    from candidates c
    left join interviews i on c.id = i.candidate_id
    group by c.id
    having count(i.id) = 0
),
numbered as (
    select full_name, email, application_date,
        row_number() over (
            order by application_date, full_name) as queue_position,
        count(*) over () as total_count
    from no_interview
)
select full_name, email, application_date, queue_position,
    round(
        case
            when total_count > 1 then (queue_position - 1) * 100.0 / (total_count - 1)
            else 0
        end, 2
    ) as older_than_pct
from numbered
order by queue_position;
