-- Xom Data · Apartments matching the client's criteria
-- Problem: https://xomdata.com/practice/easy-andor-001
-- Solved: 2026-08-25

-- Viết SQL của bạn ở đây
select listing_code, district, monthly_rent
from apartments
where district in ('Binh Thanh', 'District 3')
    and monthly_rent <= 9000000;
