-- Xom Data · Kênh nào tạo ra khách trung thành
-- Problem: https://xomdata.com/practice/medium-repeat-005
-- Solved: 2026-08-23

with customer_stats as (
    select c.customer_id, c.channel, 
        count(o.customer_id) as order_count
    from customers c
    join orders o on c.customer_id = o.customer_id
    group by c.customer_id, c.channel
)
select channel,
    count(*) as customers,
    sum(case 
            when order_count >= 3 then 1
            else 0
        end) as loyal_customers,
    round(100.0 * sum(case
                        when order_count >= 3 then 1
                        else 0 
                    end) / count(*), 2) as loyal_rate_pct
from customer_stats
group by channel
order by loyal_rate_pct desc, channel asc;
