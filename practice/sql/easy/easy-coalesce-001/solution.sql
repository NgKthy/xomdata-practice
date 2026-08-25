-- Xom Data · Display names on profile pages
-- Problem: https://xomdata.com/practice/easy-coalesce-001
-- Solved: 2026-08-25

-- Viết SQL của bạn ở đây
select real_name, nickname, 
    case
        when nickname is null then real_name
        else nickname
    end as display_name
from profiles
