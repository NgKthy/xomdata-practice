-- Xom Data · Visit number within each day
-- Problem: https://xomdata.com/practice/medium-rownum-003
-- Solved: 2026-10-19

-- Write your SQL here
select checkin_date,
    row_number() over (
        partition by checkin_date
        order by checkin_time, member_name 
    ) as visit_no,
    member_name,
    checkin_time
from checkins
order by checkin_date, visit_no;
