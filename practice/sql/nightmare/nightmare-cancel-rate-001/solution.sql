-- Xom Data · Daily trip cancellation rate (unbanned users/drivers only)
-- Problem: https://xomdata.com/practice/nightmare-cancel-rate-001
-- Solved: 2026-09-25

select t.request_at as day,
    round(sum(case 
                when t.status like '%cancelled%' then 1 
                else 0 
              end) * 1.0 / count(*), 2) as cancellation_rate
from trips t
join users c
    on c.users_id = t.client_id
   and lower(c.banned) = 'no'
join users d
    on d.users_id = t.driver_id
   and lower(d.banned) = 'no'
where t.request_at between '2024-01-01' and '2024-01-03'
group by t.request_at
order by t.request_at asc;
