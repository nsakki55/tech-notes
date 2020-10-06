SELECT user_id,
       product_id,
       score,
       AVG(score) OVER ()                             AS avg_score,
       AVG(score) OVER (PARTITION BY user_id)         AS user_avg_score,
       score - AVG(score) OVER (PARTITION BY user_id) AS user_avg_score_diff
FROM review