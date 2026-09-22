-- Xom Data · Room price list by tier
-- Problem: https://xomdata.com/practice/easy-orderby-002
-- Solved: 2026-09-22

-- Write your SQL here
select room_no, room_type, price
from rooms
order by room_type, price, room_no;
