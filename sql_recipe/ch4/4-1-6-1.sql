WITH daily_purchase AS (
    SELECT dt,
           substring(dt, 1, 4)  AS year,
           substring(dt, 6, 2)  AS month,
           substring(dt, 9, 2)  AS date,
           SUM(purchase_amount) AS purchase_amount,
           COUNT(order_id) AS orders
    FROM purchase_log
    GROUP BY dt
),

     monthly_purchase AS (
         SELECT
                year,
                month,
                SUM(orders) AS orders,
                AVG(purchase_amount) AS avg_amount,
                SUM(purchase_amount) AS monthly
         FROM daily_purchase
         GROUP BY year, month
     )

SELECT
year || '-' || month as year_month,
       orders,
       avg_amount,
        monthly,
       SUM(monthly) OVER(PARTITION BY year ORDER BY month ROWS UNBOUNDED PRECEDING ) AS agg_amount,
       LAG(monthly, 12) OVER(ORDER BY year, month) AS last_year,
       100.0 * monthly / LAG(monthly, 12) OVER(ORDER BY year, month) AS rate
FROM monthly_purchase
ORDER BY year_month