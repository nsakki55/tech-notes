WITH repeat_interval AS (
    SELECT '01 day repeat' AS index_name, 1 AS interval_date
    UNION ALL
    SELECT '02 day repeat' AS index_name, 2 AS interval_date
    UNION ALL
    SELECT '03 day repeat' AS index_name, 3 AS interval_date
    UNION ALL
    SELECT '04 day repeat' AS index_name, 4 AS interval_date
    UNION ALL
    SELECT '05 day repeat' AS index_name, 5 AS interval_date
    UNION ALL
    SELECT '06 day repeat' AS index_name, 6 AS interval_date
    UNION ALL
    SELECT '07 day repeat' AS index_name, 7 AS interval_date
),
     action_log_with_index_date AS (
         SELECT u.user_id,
                u.register_date,
                CAST(a.stamp AS date)                                      AS action_date,
                MAX(CAST(a.stamp AS date)) OVER ()                         AS latest_date,
                r.index_name,
                dateadd(day, r.interval_date, u.register_date::date)::date AS index_date
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
                                    WHEN index_date <= latest_date THEN
                                        CASE WHEN index_date = action_date THEN 1 ELSE 0 END
                                    END
                            )
                    ) AS index_date_action

         FROM action_log_with_index_date
         GROUP BY user_id, register_date, index_name, index_date
     )

SELECT register_date,
       index_name,
       AVG(100.0 * index_date_action) AS repeat_rate
FROM user_action_flag
GROUP BY register_date, index_name