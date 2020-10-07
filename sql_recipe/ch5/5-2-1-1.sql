SELECT
register_date,
COUNT(DISTINCT user_id) AS register_count
FROM mst_users
GROUP BY register_date