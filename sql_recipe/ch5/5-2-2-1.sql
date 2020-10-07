WITH action_log_with_mst_users AS (
    SELECT u.user_id,
           u.register_date,
           CAST(a.stamp AS date)                  AS action_date,
           MAX(CAST(a.stamp AS date)) OVER ()     AS latest_date,
           dateadd(day, 1, u.register_date::date) AS next_day_1
    FROM mst_users AS u
             LEFT OUTER JOIN
         action_log as a
         ON u.user_id = a.user_id
)

SELECT *
FROM action_log_with_mst_users