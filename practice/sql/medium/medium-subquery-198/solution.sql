-- Xom Data · Top 10 most-borrowed books
-- Problem: https://xomdata.com/practice/medium-subquery-198
-- Solved: 2026-10-16

with loan_counts as (
    select book_id,
        count(*) as borrow_count
    from book_loans
    group by book_id
),
res_counts as (
    select book_id,
        count(*) as pending_reservation
    from reservations
    where status = 'ready_pickup'
    group by book_id
),
book_stats as (
    select b.id, b.title, a.full_name as authors,
        p.publisher_name, g.genre_name, lc.borrow_count,
        coalesce(rc.pending_reservation, 0) as pending_reservation,
        lc.borrow_count + coalesce(rc.pending_reservation, 0) as engagement
    from books b
    join authors a on a.id = b.author_id
    join publishers p on p.id = b.publisher_id
    join genres g on g.id = b.genre_id
    join loan_counts lc on lc.book_id = b.id
    left join res_counts rc on rc.book_id = b.id
),
ranked as (
    select *,
        dense_rank() over (order by engagement desc) as overall_rank,
        rank() over (partition by genre_name order by engagement desc) as rank_in_genre
    from book_stats
)
select title, authors, publisher_name, genre_name, borrow_count, pending_reservation,
    engagement, overall_rank, rank_in_genre
from ranked
where overall_rank <= 10
order by overall_rank, title;
