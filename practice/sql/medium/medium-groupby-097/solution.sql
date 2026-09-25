-- Xom Data · Top 10 most-engaged posts
-- Problem: https://xomdata.com/practice/medium-groupby-097
-- Solved: 2026-09-25

with post_stats as (
    select p.id, u.full_name, p.post_type, p.post_date,
        (p.like_count + p.comment_count + p.share_count) as total_interactions
    from posts p
    join users u on u.id = p.user_id
),
ranked as (
    select *,
        rank() over (
            order by total_interactions desc
        ) as overall_rank,
        row_number() over (
            partition by full_name
            order by total_interactions desc, post_date
        ) as rank_in_author
    from post_stats
),
top_interactions as (
    select max(total_interactions) as max_total
    from post_stats
)
select full_name, post_type, post_date,
    total_interactions, overall_rank, rank_in_author,
    round(
        total_interactions * 100.0 / (select max_total from top_interactions),
        2
    ) as pct_of_top
from ranked
where overall_rank <= 10
order by overall_rank, full_name, rank_in_author;
