-- Xom Data · Book count and average price by genre
-- Problem: https://xomdata.com/practice/medium-coalesce-040
-- Solved: 2026-09-07

with genre_stats as (
    select g.id, g.genre_name,
        count(b.id) as book_count,
        coalesce(round(avg(b.price), 0), 0) as avg_price,
        coalesce(min(b.price), 0) as min_price,
        coalesce(max(b.price), 0) as max_price,
        coalesce(max(b.price) - min(b.price), 0) as price_range
    from genres g
    left join books b on g.id = b.genre_id
    group by g.id, g.genre_name
)
select genre_name, book_count, avg_price, min_price, max_price, price_range,
    rank() over (order by book_count desc) as coverage_rank,
    ntile(3) over (order by book_count desc, genre_name) as library_focus
from genre_stats
order by coverage_rank, genre_name;
