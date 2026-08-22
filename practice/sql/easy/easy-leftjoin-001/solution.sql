-- Xom Data · Users who never took a ride
-- Problem: https://xomdata.com/practice/easy-leftjoin-001
-- Solved: 2026-08-22

-- Viết SQL của bạn ở đây
select u.user_name, u.joined_date
from users u
left join rides r on r.user_id = u.id
where r.id is null;
