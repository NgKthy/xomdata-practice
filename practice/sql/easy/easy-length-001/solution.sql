-- Xom Data · Accounts that must be renamed
-- Problem: https://xomdata.com/practice/easy-length-001
-- Solved: 2026-09-19

-- Viết SQL của bạn ở đây
select username, level
from players
where length(username) < 6;
