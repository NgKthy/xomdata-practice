-- Xom Data · Today's showtimes in time order
-- Problem: https://xomdata.com/practice/easy-join-004
-- Solved: 2026-08-21

-- Viết SQL của bạn ở đây
select s.start_time, m.title, s.screen
from showtimes s
join movies m on m.id = s.movie_id
order by s.start_time, m.title;
