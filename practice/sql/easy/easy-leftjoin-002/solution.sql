-- Xom Data · Total spend per member
-- Problem: https://xomdata.com/practice/easy-leftjoin-002
-- Solved: 2026-08-25

-- Viết SQL của bạn ở đây
select member_name, coalesce(sum(amount), 0) as total_spent
from members m
left join bills b on b.member_id = m.id
group by m.id
order by member_name;
