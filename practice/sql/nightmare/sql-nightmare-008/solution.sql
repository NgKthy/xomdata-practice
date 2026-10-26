-- Xom Data · Score customers by RFM
-- Problem: https://xomdata.com/practice/sql-nightmare-008
-- Solved: 2026-10-26

with base as (
    select customer_id,
        max(txn_date::date) as last_txn,
        count(*) as frequency,
        sum(amount) as monetary_raw
    from transactions
    group by customer_id
),
ref as (
    select max(txn_date::date) + 1 as ref_date
    from transactions
),
stats as (
    select b.customer_id,
        (r.ref_date - b.last_txn) as recency,
        b.frequency,
        b.monetary_raw
    from base b
    cross join ref r
),
scored as (
    select customer_id, recency, frequency, monetary_raw,
        ntile(5) over (
            order by recency desc, customer_id 
        ) as r_score,
        ntile(5) over (
            order by frequency, customer_id 
        ) as f_score,
        ntile(5) over (
            order by monetary_raw, customer_id 
        ) as m_score
    from stats
)
select customer_id, recency, frequency,
    round(monetary_raw::numeric, 2) as monetary,
    r_score, f_score, m_score,
    round(
        r_score * 0.4 + f_score * 0.3 + m_score * 0.3,
        2
    ) as rfm_score
from scored
order by rfm_score desc, customer_id;
