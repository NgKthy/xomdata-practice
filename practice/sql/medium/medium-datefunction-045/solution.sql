-- Xom Data · Transaction count and amount by month
-- Problem: https://xomdata.com/practice/medium-datefunction-045
-- Solved: 2026-09-07

with monthly as (
    select substr(transaction_date, 1, 7) as month,
        count(*) as transaction_count,
        sum(amount) as total_amount
    from transactions
    group by month
)
select month, transaction_count, total_amount,
    total_amount - lag(total_amount, 1) over (order by month) as mom_delta
from monthly
order by month;
