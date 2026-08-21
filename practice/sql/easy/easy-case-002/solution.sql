-- Xom Data · Sizing parcels by weight
-- Problem: https://xomdata.com/practice/easy-case-002
-- Solved: 2026-08-21

-- Viết SQL của bạn ở đây
select parcel_code, weight_kg,
    case 
        when weight_kg < 5 then 'Small'
        when weight_kg > 20 then 'Large'
        else 'Medium'
    end as size_label
from parcels;
