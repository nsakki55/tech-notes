SELECT dt,
       substring(dt, 1, 7)                                                           AS year_month,
       SUM(purchase_amount)                                                          AS total_amount,
       SUM(SUM(purchase_amount))
       OVER (PARTITION BY substring(dt, 1, 7) ORDER BY dt ROWS UNBOUNDED PRECEDING ) AS avg_amount

FROM purchase_log
GROUP BY dt
ORDER BY dt