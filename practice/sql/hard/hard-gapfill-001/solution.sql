-- Xom Data · Daily revenue including zero-sale days
-- Problem: https://xomdata.com/practice/hard-gapfill-001
-- Solved: 2026-09-09

WITH RECURSIVE date_range AS (
    SELECT MIN(date) AS date FROM daily_revenue
    UNION ALL
    SELECT DATE(date, '+1 day')
    FROM date_range
    WHERE date < (SELECT MAX(date) FROM daily_revenue)
)
SELECT
    date_range.date,
    COALESCE(SUM(daily_revenue.amount), 0) AS revenue
FROM date_range
LEFT JOIN daily_revenue ON date_range.date = daily_revenue.date
GROUP BY date_range.date
ORDER BY date_range.date;
