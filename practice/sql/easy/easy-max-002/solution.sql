-- Xom Data · Peak-hour electricity record
-- Problem: https://xomdata.com/practice/easy-max-002
-- Solved: 2026-09-10

-- Write your SQL here
select max(kwh) as peak_load
from power_readings
where period = 'Peak';
