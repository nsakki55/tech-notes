WITH user_purchase_amount AS (
    SELECT user_id,
           SUM(amount) AS purchase_amount
    FROM action_log
    WHERE action = 'purchase'
    GROUP BY user_id
),
     users_with_decile AS (
         SELECT user_id,
                purchase_amount,
                ntile(10) OVER (ORDER BY purchase_amount DESC) AS decile
         FROM user_purchase_amount
     ),
     decile_with_purchase_amount AS (
         SELECT decile,
                SUM(purchase_amount)                                                     AS amount,
                AVG(purchase_amount)                                                     AS avg_amount,
                SUM(SUM(purchase_amount))
                OVER (ORDER BY decile ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS cumulative_amount,
                SUM(SUM(purchase_amount)) OVER ()                                        AS total_amount
         FROM users_with_decile
         GROUP BY decile
     )

SELECT decile,
       amount,
       avg_amount,
       100.0 * amount / total_amount            AS total_ratio,
       100.0 * cumulative_amount / total_amount AS cumulative_ratio
FROM decile_with_purchase_amount