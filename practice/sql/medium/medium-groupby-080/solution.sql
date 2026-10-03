-- Xom Data · Monthly income and expense report
-- Problem: https://xomdata.com/practice/medium-groupby-080
-- Solved: 2026-10-03

with monthly as (
    select
        strftime('%Y-%m', transaction_date) as month,
        sum(case when type = 'Income' then amount else 0 end) as total_income,
        sum(case when type = 'Expense' then amount else 0 end) as total_expense
    from transactions
    group by strftime('%Y-%m', transaction_date)
)
select month, total_income, total_expense,
    total_income - total_expense as balance,
    sum(total_income - total_expense) over (
        order by month
    ) as cumulative_balance,
    case
        when total_income > total_expense then 'Surplus'
        when total_income < total_expense then 'Deficit'
        else 'Balanced'
    end as status
from monthly
order by month;
