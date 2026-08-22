-- Xom Data · Parcels bound for Da Nang
-- Problem: https://xomdata.com/practice/easy-join-002
-- Solved: 2026-08-22

-- Viết SQL của bạn ở đây
select p.tracking_code, r.recipient_name
from recipients r
join parcels p on p.recipient_id = r.id
where r.city = 'Da Nang';
