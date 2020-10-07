WITH monthly_user_actions AS (
    SELECT DISTINCT u.user_id,
                    substring(u.register_date, 1, 7)                               AS register_month,
                    substring(l.stamp, 1, 7)                                       AS action_month,
                    substring(
                            CAST(dateadd(month, -1, l.stamp::date) AS text), 1, 7) AS action_month_priv
    FROM mst_users AS u
             JOIN
         action_log AS l
         ON u.user_id = l.user_id
),
     monthly_user_with_type AS (
         SELECT action_month,
                user_id,
                CASE
                    WHEN register_month = action_month THEN 'new_user'
                    WHEN action_month_priv = LAG(action_month) OVER (PARTITION BY user_id ORDER BY action_month)
                        THEN 'repeat_user'
                    ELSE 'come_back_user'
                    END AS c,
                action_month_priv
         FROM monthly_user_actions
     ),monthly_users AS (
    SELECT m1.action_month,
           COUNT(m1.user_id)                                                            AS mau,
           COUNT(CASE WHEN m1.c = 'new_user' THEN 1 END)                                AS new_users,
           COUNT(CASE WHEN m1.c = 'repeat_user' THEN 1 END)                             AS repeat_users,
           COUNT(CASE WHEN m1.c = 'come_back_user' THEN 1 END)                          AS come_back_users,
           COUNT(CASE WHEN m1.c = 'repeat_user' AND m0.c = 'new_user' THEN 1 END)       AS new_repeat_users,
           COUNT(CASE WHEN m1.c = 'repeat_user' AND m0.c = 'repeat_user' THEN 1 END)    AS continuous_repeat_users,
           COUNT(CASE WHEN m1.c = 'repeat_user' AND m0.c = 'come_back_user' THEN 1 END) AS come_back_repeat_users

    FROM monthly_user_with_type AS m1
             LEFT OUTER JOIN
         monthly_user_with_type AS m0
         ON m1.user_id = m0.user_id
             AND m1.action_month_priv = m0.action_month
    GROUP BY m1.action_month
)
SELECT
action_month,
mau,
new_users,
repeat_users,
come_back_users,
new_repeat_users,
continuous_repeat_users,
come_back_repeat_users,
100.0 * new_repeat_users / NULLIF(LAG(new_users) OVER(ORDER BY action_month), 0) AS priv_new_repeat_ratio,
100.0 * continuous_repeat_users / NULLIF(LAG(repeat_users) OVER(ORDER BY action_month), 0) AS priv_continuous_repeat_ratio,
100.0 * come_back_repeat_users / NULLIF(LAG(come_back_users) OVER(ORDER BY action_month), 0) AS priv_come_back_repeat_ratio
FROM monthly_users
