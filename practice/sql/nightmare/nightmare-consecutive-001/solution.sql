-- Xom Data · Numbers appearing 3 times in a row in the log
-- Problem: https://xomdata.com/practice/nightmare-consecutive-001
-- Solved: 2026-10-28

with numbered as (
    select id, num,
        lead(id) over (order by id) as next_id,
        lead(num) over (order by id) as next_num,
        lead(id, 2) over (order by id) as next2_id,
        lead(num, 2) over (order by id) as next2_num
    from logs
)
select distinct num as consecutive_num
from numbered
where num = next_num
  and num = next2_num
  and next_id = id + 1
  and next2_id = id + 2
order by consecutive_num;
