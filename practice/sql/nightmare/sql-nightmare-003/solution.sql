-- Xom Data · 3-month consecutive disbursement rate by department
-- Problem: https://xomdata.com/practice/sql-nightmare-003
-- Solved: 2026-09-30

select dept, month,
    sum(budget) over (
        partition by dept
        order by month
        rows between 2 preceding and current row
    ) as roll3_budget,
    sum(actual) over (
        partition by dept
        order by month
        rows between 2 preceding and current row
    ) as roll3_actual,
    round(
        100.0 * sum(actual) over (
            partition by dept
            order by month
            rows between 2 preceding and current row
        ) / nullif(
            sum(budget) over (
                partition by dept
                order by month
                rows between 2 preceding and current row
            ), 0
        ),
        2
    ) as utilization_pct
from budgets
order by dept, month;
