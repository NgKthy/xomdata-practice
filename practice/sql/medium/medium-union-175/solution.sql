-- Xom Data · Summary of issues to handle
-- Problem: https://xomdata.com/practice/medium-union-175
-- Solved: 2026-09-11

WITH issues AS (
    SELECT 'Complaint' AS type, COUNT(*) AS quantity
    FROM complaints
    WHERE status = 'Pending'

    UNION ALL

    SELECT 'Cancelled Order', COUNT(*)
    FROM orders
    WHERE status = 'Cancelled'

    UNION ALL

    SELECT 'Out of Stock Product', COUNT(*)
    FROM products
    WHERE status = 'Out of Stock'
),
totals AS (
    SELECT
        type,
        quantity,
        SUM(quantity) OVER () AS total_qty
    FROM issues
),
ranked AS (
    SELECT
        type,
        quantity,
        ROUND(quantity * 100.0 / NULLIF(total_qty, 0), 2) AS pct_of_total,
        RANK() OVER (ORDER BY quantity DESC) AS rank_pos,
        quantity * 100.0 / NULLIF(total_qty, 0) AS raw_pct
    FROM totals
)
SELECT
    type,
    quantity,
    pct_of_total,
    rank_pos,
    ROUND(
        SUM(raw_pct) OVER (
            ORDER BY rank_pos ASC, type ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ),
        2
    ) AS cumulative_pct
FROM ranked
ORDER BY rank_pos ASC, type ASC;
