-- Xom Data · Most watched videos this week
-- Problem: https://xomdata.com/practice/easy-orderby-003
-- Solved: 2026-08-28

-- Viết SQL của bạn ở đây
select video_title, weekly_views
from videos
order by weekly_views desc, video_title;
