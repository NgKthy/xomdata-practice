-- Xom Data · Allocate contract revenue across years
-- Problem: https://xomdata.com/practice/nightmare-prorate-001
-- Solved: 2026-10-02

with recursive
bounds as (
    select
        min(cast(substr(start_date, 1, 4) as integer)) as min_year,
        max(cast(substr(end_date, 1, 4) as integer)) as max_year
    from contracts
),
years as (
    select min_year as year from bounds
    union all
    select year + 1
    from years
    where year < (select max_year from bounds)
),
contract_years as (
    select
        c.id as contract_id,
        y.year,
        c.amount,
        cast(
            julianday(c.end_date) - julianday(c.start_date) + 1
            as integer
        ) as total_days,
        cast(
            julianday(min(c.end_date, y.year || '-12-31')) -
            julianday(max(c.start_date, y.year || '-01-01')) + 1
            as integer
        ) as days_in_year
    from contracts c
    join years y
        on y.year between
            cast(substr(c.start_date, 1, 4) as integer) and
            cast(substr(c.end_date, 1, 4) as integer)
)
select
    contract_id,
    year,
    round(amount * days_in_year * 1.0 / total_days, 2) as prorated_amount
from contract_years
order by contract_id, year;
