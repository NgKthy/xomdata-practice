-- Xom Data · Showtime count and average ticket price per film
-- Problem: https://xomdata.com/practice/medium-join-076
-- Solved: 2026-09-19

with movie_avg as (
    select m.id, m.movie_name, m.genres,
        count(s.id) as showtime_count,
        round(avg(s.ticket_price), 0) as avg_ticket_price
    from movies m
    left join showtimes s
        on s.movie_id = m.id
    group by m.id, m.movie_name, m.genres
),
ranked as (
    select *,
        dense_rank() over (partition by genres
                           order by avg_ticket_price desc) as rank_in_genre,
        first_value(movie_name) over (partition by genres
                                      order by avg_ticket_price desc, movie_name) as top_movie_in_genre
    from movie_avg
)
select movie_name, genres, showtime_count, avg_ticket_price,
    rank_in_genre, top_movie_in_genre
from ranked
order by genres, rank_in_genre, movie_name;
