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
     )

SELECT *
FROM users_with_decile