WITH daily_purchase AS (
    SELECT dt,
           substring(dt, 1, 4)  AS year,
           substring(dt, 6, 2)  AS month,
           substring(dt, 9, 2)  AS date,
           SUM(purchase_amount) AS purchase_amount
    FROM purchase_log
    GROUP BY dt
)

SELECT *
FROM daily_purchase
ORDER BY dt