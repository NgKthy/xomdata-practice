-- Xom Data · Swap seats in pairs (1↔2, 3↔4, …)
-- Problem: https://xomdata.com/practice/nightmare-exchange-seats-001
-- Solved: 2026-09-25

select s.id, coalesce(s2.student, s.student) as student
from seats s
left join seats s2
    on s2.id = case
                    when s.id % 2 = 1 then s.id + 1
                    else s.id - 1
               end
order by s.id;
