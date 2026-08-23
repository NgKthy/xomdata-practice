-- Xom Data · Which sales channel leads in orders
-- Problem: https://xomdata.com/practice/easy-groupby-004
-- Solved: 2026-08-23

-- Viết SQL của bạn ở đây
select channel, count(*) as num_orders
from orders
group by channel
order by num_orders desc, channel;
