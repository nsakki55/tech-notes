WITH unique_action_log AS (
    SELECT DISTINCT user_id,
                    substring(stamp, 1, 10) AS action_date
    FROM action_log
),
     mst_calendar AS (
         SELECT '2016-10-01' AS dt
         UNION ALL
         SELECT '2016-10-02' AS dt
         UNION ALL
         SELECT '2016-10-03' AS dt
     ),
     target_date_with_user AS (
         SELECT c.dt AS target_date,
                u.user_id,
                u.register_date,
                u.withdraw_date
         FROM mst_users AS u
                  CROSS JOIN
              mst_calendar AS c
     ),
     user_status_log AS (
         SELECT u.target_date,
                u.user_id,
                u.register_date,
                u.withdraw_date,
                a.action_date,
                CASE WHEN u.register_date = a.action_date THEN 1 ELSE 0 END AS is_new,
                CASE WHEN u.withdraw_date = a.action_date THEN 1 ELSE 0 END AS is_exit,
                CASE WHEN u.target_date = a.action_date THEN 1 ELSE 0 END   AS is_access,
                LAG(CASE WHEN u.target_date = a.action_date THEN 1 ELSE 0 END)
                OVER (PARTITION BY u.user_id ORDER BY u.target_date)        AS was_access
         FROM target_date_with_user AS u
                  LEFT JOIN
              unique_action_log AS a
              ON u.user_id = a.user_id
                  AND u.target_date = a.action_date
         WHERE u.register_date <= u.target_date
           AND (u.withdraw_date IS NULL OR u.target_date <= u.withdraw_date)
     )
SELECT target_date,
       user_id,
       is_new,
       is_exit,
       is_access,
       was_access
FROM user_status_log