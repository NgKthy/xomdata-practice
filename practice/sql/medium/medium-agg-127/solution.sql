-- Xom Data · Top 10 highest-paid employees and their leave days
-- Problem: https://xomdata.com/practice/medium-agg-127
-- Solved: 2026-09-09

WITH payroll_sum AS (
    SELECT employee_id, SUM(net_salary) AS total_salary
    FROM payroll
    GROUP BY employee_id
),
leave_count AS (
    SELECT employee_id, COUNT(*) AS leave_count
    FROM leaves
    WHERE status = 'approved'
    GROUP BY employee_id
),
employee_salary AS (
    SELECT 
        e.id AS employee_id,
        e.full_name,
        e.employee_code,
        e.department_id,
        d.department_name,
        COALESCE(p.total_salary, 0) AS total_received_salary,
        COALESCE(l.leave_count, 0) AS leave_count
    FROM employees e
    JOIN departments d ON e.department_id = d.id
    LEFT JOIN payroll_sum p ON e.id = p.employee_id
    LEFT JOIN leave_count l ON e.id = l.employee_id
),
dept_avg AS (
    SELECT 
        department_id,
        AVG(total_received_salary) AS avg_salary
    FROM employee_salary
    GROUP BY department_id
)
SELECT 
    es.full_name,
    es.employee_code,
    es.department_name,
    es.total_received_salary,
    es.leave_count,
    ROUND(
        CASE 
            WHEN da.avg_salary = 0 THEN 0
            ELSE (es.total_received_salary - da.avg_salary) * 100.0 / da.avg_salary
        END, 2
    ) AS pct_above_dept_avg
FROM employee_salary es
JOIN dept_avg da ON es.department_id = da.department_id
ORDER BY es.total_received_salary DESC, es.employee_code ASC
LIMIT 10;
