-- Xom Data · Players with 3 or more goals
-- Problem: https://xomdata.com/practice/medium-having-187
-- Solved: 2026-10-12

with player_goals as (
    select player_id,
        count(*) as goal_count,
        count(distinct match_id) as scoring_matches
    from goals
    group by player_id
),
player_penalties as (
    select player_id,
        count(*) as cards_received
    from penalties
    group by player_id
),
stats as (
    select p.full_name, p.positions, t.team_name, pg.goal_count, pg.scoring_matches,
        coalesce(pp.cards_received, 0) as cards_received,
        round(pg.goal_count * 1.0 / pg.scoring_matches, 2) as goals_per_match
    from players p
    join teams t on t.id = p.team_id
    join player_goals pg on pg.player_id = p.id
    left join player_penalties pp on pp.player_id = p.id
    where pg.goal_count >= 3
      and coalesce(pp.cards_received, 0) < 5
)
select full_name, positions, team_name, goal_count,
    scoring_matches, cards_received, goals_per_match,
    dense_rank() over (order by goals_per_match desc) as efficiency_rank,
    rank() over (order by goal_count desc) as volume_rank
from stats
order by efficiency_rank, full_name;
