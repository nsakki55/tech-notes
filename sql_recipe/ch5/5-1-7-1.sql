WITH purchase_log AS (
    SELECT user_id,
           amount,
           substring(stamp, 1, 10) AS dt
    FROM action_log
    WHERE action = 'purchase'
),
     user_rfm AS (
         SELECT user_id,
                MAX(dt)                      AS recent_date,
                CURRENT_DATE - MAX(dt::date) AS recency,
                COUNT(dt)                    AS frequency,
                SUM(amount)                  AS monetary
         FROM purchase_log
         GROUP BY user_id
     )
SELECT *
FROM user_rfm
