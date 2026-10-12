-- Xom Data · Goals and cards by team
-- Problem: https://xomdata.com/practice/medium-join-186
-- Solved: 2026-10-12

with team_stats as (
    select t.id, t.team_name, t.city,
        (select count(*) from players p where p.team_id = t.id) as player_count,
        (select count(*) from goals g join players p on p.id = g.player_id where p.team_id = t.id) as total_goals_scored,
        (select count(*) from penalties pen join players p on p.id = pen.player_id where p.team_id = t.id) as penalty_count
    from teams t
),
calc as (
    select team_name, city, player_count,
        total_goals_scored, penalty_count,
        case
            when player_count = 0 then 0
            else round(total_goals_scored * 1.0 / player_count, 2)
        end as goals_per_player,
        case
            when player_count = 0 then 0
            else round(penalty_count * 1.0 / player_count, 2)
        end as cards_per_player
    from team_stats
)
select team_name, city, player_count, total_goals_scored,
    penalty_count, goals_per_player, cards_per_player,
    rank() over (order by total_goals_scored desc) as scoring_rank,
    sum(total_goals_scored) over (
        order by total_goals_scored desc, team_name
    ) as cumulative_goals
from calc
order by scoring_rank, team_name;
