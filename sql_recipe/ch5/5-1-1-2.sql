WITH action_log_with_status AS (
    SELECT session,
           user_id,
           action,
           CASE WHEN COALESCE(user_id, '') <> '' THEN 'login' ELSE 'guest' END
               AS login_status
    FROM action_log
)

SELECT *
FROM action_log_with_status