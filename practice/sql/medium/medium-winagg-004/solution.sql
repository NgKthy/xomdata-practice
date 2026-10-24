-- Xom Data · How far from the server's top
-- Problem: https://xomdata.com/practice/medium-winagg-004
-- Solved: 2026-10-24

-- Write your SQL here
select server, player_name, points,
    max(points) over (partition by server) - points as gap_to_top
from players
order by server, points desc, player_name;
