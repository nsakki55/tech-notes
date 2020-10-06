WITH action_log_with_status AS (
    SELECT session,
           user_id,
           action,
           CASE WHEN COALESCE(MAX(user_id)
           OVER(PARTITION BY session ORDER BY stamp ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),
           '') <> '' THEN 'member'
            ELSE 'none'
            END AS member_status,
            stamp
    FROM action_log
)

SELECT *
FROM action_log_with_status

