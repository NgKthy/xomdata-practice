-- Xom Data · Safety training results
-- Problem: https://xomdata.com/practice/easy-case-001
-- Solved: 2026-08-21

-- Viết SQL của bạn ở đây
select trainee_name, score, 
        case 
            when score >= 70 then 'Pass'
            else 'Fail'
        end as result
from trainees;
