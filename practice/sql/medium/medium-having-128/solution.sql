-- Xom Data · Employees averaging over 5 overtime hours
-- Problem: https://xomdata.com/practice/medium-having-128
-- Solved: 2026-10-10

with att_avg as (
    select employee_id,
        avg(work_days) as avg_work_days,
        avg(overtime_hours) as avg_overtime_hours
    from attendance
    group by employee_id
),
pay_avg as (
    select employee_id,
        avg(net_salary) as avg_salary
    from payroll
    group by employee_id
),
filtered as (
    select e.id, e.full_name, e.employee_code, a.avg_work_days, a.avg_overtime_hours, p.avg_salary,
        round(a.avg_overtime_hours * 1.0 / a.avg_work_days, 4) as overtime_intensity
    from employees e
    join att_avg a on a.employee_id = e.id
    left join pay_avg p on p.employee_id = e.id
    where a.avg_overtime_hours > 5
      and a.avg_work_days >= 18
)
select full_name, employee_code, avg_work_days, avg_overtime_hours, avg_salary, overtime_intensity,
    rank() over (order by overtime_intensity desc) as intensity_rank,
    ntile(4) over (order by overtime_intensity desc, employee_code) as workload_quartile
from filtered
order by intensity_rank, employee_code;
