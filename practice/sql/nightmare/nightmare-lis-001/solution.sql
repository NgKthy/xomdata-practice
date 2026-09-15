-- Xom Data · Longest rising price run over N trading sessions
-- Problem: https://xomdata.com/practice/nightmare-lis-001
-- Solved: 2026-09-15

with recursive numbered as (
    select day, price,
        row_number() over(order by day) as rn
    from prices
),
subseqs as (
    select rn, price,
        printf('%.1f', price) as seq,
        1 as len
    from numbered
    union all
    select n.rn, n.price,
        s.seq || ',' || printf('%.1f', n.price),
        s.len + 1
    from subseqs s
    join numbered n on n.rn > s.rn 
                    and n.price > s.price
)
select len as lis_length, seq as lis_sequence
from subseqs
order by len desc, seq
limit 1;
