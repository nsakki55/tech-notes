WITH daily_purchase AS (
    SELECT dt,
           substring(dt, 1, 4)  AS year,
           substring(dt, 6, 2)  AS month,
           substring(dt, 9, 2)  AS date,
           SUM(purchase_amount) AS purchase_amount
    FROM purchase_log
    GROUP BY dt
)


SELECT month,

       SUM(CASE year WHEN '2014' THEN purchase_amount END)       AS amount_2014,
       SUM(CASE year WHEN '2015' THEN purchase_amount END)       AS amount_2015,
       100.0 * SUM(CASE year WHEN '2015' THEN purchase_amount END) / SUM(CASE year WHEN '2014' THEN purchase_amount END) AS rate
FROM daily_purchase
GROUP BY month
ORDER BY month
