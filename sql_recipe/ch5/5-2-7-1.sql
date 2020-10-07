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
     )

SELECT action_month,
       COUNT(user_id)                                   AS mau,
       COUNT(CASE WHEN c = 'new_user' THEN 1 END)       AS new_users,
       COUNT(CASE WHEN c = 'repeat_user' THEN 1 END)    AS repeat_users,
       COUNT(CASE WHEN c = 'come_back_user' THEN 1 END) AS come_back_users
FROM monthly_user_with_type
GROUP BY action_month