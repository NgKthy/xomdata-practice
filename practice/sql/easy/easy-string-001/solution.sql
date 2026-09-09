-- Xom Data · Normalize codes for label printing
-- Problem: https://xomdata.com/practice/easy-string-001
-- Solved: 2026-09-09

-- Write your SQL here
select sku, upper(sku) as label_code
from inventory;
