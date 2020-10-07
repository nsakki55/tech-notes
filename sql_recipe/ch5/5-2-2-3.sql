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
),
     user_action_flag AS (
         SELECT user_id,
                register_date,
                SIGN(
                        SUM(
                                CASE
                                    WHEN next_day_1 <= latest_date THEN
                                        CASE WHEN next_day_1 = action_date THEN 1 ELSE 0 END
                                    END
                            )
                    ) AS next_1_day_action

         FROM action_log_with_mst_users
         GROUP BY user_id, register_date
     )
SELECT
register_date,
AVG(100.0 * next_1_day_action) AS repeat_rate_1_day
FROM user_action_flag
GROUP BY register_date