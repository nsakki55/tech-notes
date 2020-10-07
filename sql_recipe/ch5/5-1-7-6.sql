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
     ),
     user_rfm_rank AS (
         SELECT user_id,
                recency,
                frequency,
                monetary,
                CASE
                    WHEN recency < 14 THEN 5
                    WHEN recency < 28 THEN 4
                    WHEN recency < 60 THEN 3
                    WHEN recency < 90 THEN 2
                    ELSE 1
                    END AS r,

                CASE
                    WHEN 20 <= frequency THEN 5
                    WHEN 10 <= frequency THEN 4
                    WHEN 5 <= frequency THEN 3
                    WHEN 2 <= frequency THEN 2
                    ELSE 1
                    END AS f,

                CASE
                    WHEN 300000 <= monetary THEN 5
                    WHEN 100000 <= monetary THEN 4
                    WHEN 30000 <= monetary THEN 3
                    WHEN 5000 <= monetary THEN 2
                    ELSE 1
                    END AS m
         FROM user_rfm
     )
     SELECT
     CONCAT('r_', r) AS r_rank,
     COUNT(CASE WHEN f = 5 THEN 1 END ) AS f_5,
     COUNT(CASE WHEN f = 4 THEN 1 END ) AS f_4,
     COUNT(CASE WHEN f = 3 THEN 1 END ) AS f_3,
     COUNT(CASE WHEN f = 2 THEN 1 END ) AS f_2,
     COUNT(CASE WHEN f = 1 THEN 1 END ) AS f_1
     FROM user_rfm_rank
     GROUP BY r
