-- Xom Data · Deal count per client
-- Problem: https://xomdata.com/practice/easy-join-007
-- Solved: 2026-08-21

-- Viết SQL của bạn ở đây
select c.client_name, count(d.id) as num_deals
from clients c
join deals d on d.client_id = c.id
group by d.client_id
order by num_deals desc, c.client_name;
