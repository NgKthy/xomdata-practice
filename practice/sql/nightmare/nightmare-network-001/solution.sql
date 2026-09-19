-- Xom Data · Friends of friends within 2 hops
-- Problem: https://xomdata.com/practice/nightmare-network-001
-- Solved: 2026-09-19

with edges as (
    select user_a as u, user_b as v from friendships
    union
    select user_b as u, user_a as v from friendships
),
suggestions as (
    select e1.u as user_id,
        e2.v as friend_of_friend,
        count(distinct e1.v) as n_mutual
    from edges e1
    join edges e2
        on e1.v = e2.u
    where e1.u != e2.v
      and not exists (
          select 1
          from edges e3
          where e3.u = e1.u
            and e3.v = e2.v
      )
    group by e1.u, e2.v
)
select user_id, friend_of_friend, n_mutual
from suggestions
order by user_id, n_mutual desc, friend_of_friend;
