-- Xom Data · Top 2 salespeople by sales each month
-- Problem: https://xomdata.com/practice/expert-final-multi-007
-- Solved: 2026-09-01

with monthly_sales as (
    select employee_id, month, sum(revenue) as total_sales
    from sales
    group by employee_id, month
),
ranked as (
    select m.month, m.employee_id, e.full_name, m.total_sales,
        dense_rank() over (
            partition by m.month
            order by m.total_sales desc
        ) as hang
    from monthly_sales m
    join employees e on m.employee_id = e.id
)
select month, hang, employee_id, full_name, total_sales
from ranked
where hang <= 2
order by month, hang, employee_id;
