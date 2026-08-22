-- Xom Data · Records with a contact number
-- Problem: https://xomdata.com/practice/easy-isnull-003
-- Solved: 2026-08-22

-- Viết SQL của bạn ở đây
select patient_name, phone
from patients
where phone is not null;
