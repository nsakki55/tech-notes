WITH repeat_interval AS (
    SELECT '01 day repeat' AS index_name, 1 AS interval_begin_date, 1 AS interval_end_date
),
     action_log_with_index_date AS (
         SELECT u.user_id,
                u.register_date,
                CAST(a.stamp AS date)                                            AS action_date,
                MAX(CAST(a.stamp AS date)) OVER ()                               AS latest_date,
                r.index_name,
                dateadd(day, r.interval_begin_date, u.register_date::date)::date AS index_begin_date,
                dateadd(day, r.interval_end_date, u.register_date::date)::date   AS index_end_date
         FROM mst_users AS u
                  LEFT OUTER JOIN
              action_log as a
              ON u.user_id = a.user_id
                  CROSS JOIN
              repeat_interval AS r
     ),
     user_action_flag AS (
         SELECT user_id,
                register_date,
                index_name,
                SIGN(
                        SUM(
                                CASE
                                    WHEN index_end_date <= latest_date THEN
                                        CASE
                                            WHEN action_date BETWEEN index_begin_date AND index_end_date
                                                THEN 1
                                            ELSE 0
                                            END
                                    END
                            )
                    ) AS index_date_action

         FROM action_log_with_index_date
         GROUP BY user_id, register_date, index_name, index_begin_date, index_end_date
     )
        ,
     mst_actions AS (
         SELECT 'view' AS action
         UNION ALL
         SELECT 'comment' AS action
         UNION ALL
         SELECT 'follow' AS action
     ),
     mst_user_actions AS (
         SELECT u.user_id,
                u.register_date,
                a.action
         FROM mst_users AS u
                  CROSS JOIN
              mst_actions AS a
     )

SELECT DISTINCT m.user_id,
                m.register_date,
                m.action,
                CASE
                    WHEN a.action IS NOT NULL THEN 1
                    ELSE 0
                    END AS do_action,
                index_name,
                index_date_action

FROM mst_user_actions AS m
         LEFT JOIN
     action_log AS a
     ON m.user_id = a.user_id
         --AND CAST(m.register_date AS date) = CAST(a.stamp AS date)
         AND m.action = a.action

         LEFT JOIN
     user_action_flag AS f
     ON m.user_id = f.user_id
WHERE f.index_date_action IS NOT NULL