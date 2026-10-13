-- Xom Data · Latest readings and over-limit alerts
-- Problem: https://xomdata.com/practice/medium-dedup-003
-- Solved: 2026-10-13

-- Write your SQL here
with ranked as (
    select s.sensor_name, r.reading_date, r.temp_c, s.max_temp,
        row_number() over (
            partition by s.id
            order by r.reading_date desc
        ) as rn
    from sensors s
    join readings r
        on r.sensor_id = s.id
)
select sensor_name, reading_date, temp_c, max_temp,
    case
        when temp_c > max_temp then 'Alert'
        else 'Normal'
    end as status
from ranked
where rn = 1
order by sensor_name;
