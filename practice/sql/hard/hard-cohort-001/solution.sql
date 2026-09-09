-- Xom Data · Retention rate by signup-month cohort
-- Problem: https://xomdata.com/practice/hard-cohort-001
-- Solved: 2026-09-09

select 
    strftime('%Y-%m', s.signup_date) as signup_month,
    strftime('%Y-%m', a.active_date) as active_month,
    count(distinct a.user_id) as n_active
from signups s
join activity a on s.user_id = a.user_id
where strftime('%Y-%m', a.active_date) >= strftime('%Y-%m', s.signup_date)
group by signup_month, active_month
order by signup_month, active_month;
