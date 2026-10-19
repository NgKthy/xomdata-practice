-- Xom Data · Each customer's latest contact number
-- Problem: https://xomdata.com/practice/medium-dedup-001
-- Solved: 2026-10-19

-- Write your SQL here
with ranked as (
    select customer_name, phone, updated_date,
        row_number() over (
            partition by customer_name
            order by updated_date desc
        ) as rn
    from contact_updates
)
select customer_name, phone, updated_date
from ranked
where rn = 1
order by customer_name;
