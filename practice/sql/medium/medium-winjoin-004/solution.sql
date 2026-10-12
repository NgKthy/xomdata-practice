-- Xom Data · The same customer's previous order
-- Problem: https://xomdata.com/practice/medium-winjoin-004
-- Solved: 2026-10-12

-- Write your SQL here
with p as (
    select m.member_name, p.purchase_date, p.amount,
        lag(p.amount) over (
            partition by p.member_id
            order by p.purchase_date asc
        ) as prev_amount
    from purchases p
    join members m
        on m.id = p.member_id
)
select member_name, purchase_date, amount, prev_amount
from p
order by member_name, purchase_date;
