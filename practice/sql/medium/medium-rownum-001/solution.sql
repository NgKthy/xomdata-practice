-- Xom Data · Interview call numbers
-- Problem: https://xomdata.com/practice/medium-rownum-001
-- Solved: 2026-10-24

-- Write your SQL here
select
    row_number() over (
        order by score desc, candidate_name 
    ) as call_no,
    candidate_name,
    score
from candidates
order by call_no;
