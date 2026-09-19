-- Xom Data · Booking count per branch
-- Problem: https://xomdata.com/practice/easy-leftjoin-003
-- Solved: 2026-09-19

-- Write your SQL here
select b.branch_name, 
    count(bk.id) as num_bookings
from branches b
left join bookings bk
    on bk.branch_id = b.id
group by b.id, b.branch_name
order by b.branch_name;
