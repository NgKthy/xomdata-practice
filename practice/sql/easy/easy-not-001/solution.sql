-- Xom Data · Devices ready for dispatch
-- Problem: https://xomdata.com/practice/easy-not-001
-- Solved: 2026-08-28

-- Viết SQL của bạn ở đây
select device_code, status
from devices
where status != 'Maintenance'
