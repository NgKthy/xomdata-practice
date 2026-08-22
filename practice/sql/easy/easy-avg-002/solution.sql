-- Xom Data · The cafe's average rating
-- Problem: https://xomdata.com/practice/easy-avg-002
-- Solved: 2026-08-22

-- Viết SQL của bạn ở đây
select round(avg(rating),2) as avg_rating
from reviews;
