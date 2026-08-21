-- Xom Data · Ticket statuses guests can read
-- Problem: https://xomdata.com/practice/easy-join-005
-- Solved: 2026-08-21

-- Viết SQL của bạn ở đây
select t.ticket_code, s.status_name
from statuses s
join tickets t on t.status_code = s.code;
