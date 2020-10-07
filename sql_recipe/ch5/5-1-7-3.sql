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
     ),
     mst_rfm_index AS (
         SELECT 1 AS rfm_index
         UNION ALL
         SELECT 2 AS rfm_index
         UNION ALL
         SELECT 3 AS rfm_index
         UNION ALL
         SELECT 4 AS rfm_index
         UNION ALL
         SELECT 5 AS rfm_index
     ),
     rfm_flag AS (
         SELECT m.rfm_index,
                CASE WHEN m.rfm_index = r.r THEN 1 ELSE 0 END AS r_flag,
                CASE WHEN m.rfm_index = r.f THEN 1 ELSE 0 END AS f_flag,
                CASE WHEN m.rfm_index = r.m THEN 1 ELSE 0 END AS m_flag
         FROM mst_rfm_index AS m
                  CROSS JOIN user_rfm_rank AS r
     )
SELECT rfm_index,
       SUM(r_flag) AS r,
       SUM(f_flag) AS f,
       SUM(m_flag) AS m
FROM rfm_flag
GROUP BY rfm_index