-- Xom Data · Tickets still valid
-- Problem: https://xomdata.com/practice/easy-count-010
-- Solved: 2026-08-23

-- Viết SQL của bạn ở đây
select count(*) as valid_tickets
from tickets
where status = 'Valid';
