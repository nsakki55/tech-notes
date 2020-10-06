WITH
stats AS (
SELECT
COUNT(DISTINCT session) AS total_uu
FROM action_log
)

SELECT l.action,
       COUNT(DISTINCT l.session) AS action_uu,
       COUNT(1) AS action_count,
       s.total_uu,
       100.0 * COUNT(DISTINCT l.session) / s.total_uu AS usage_rate,
       1.0 * COUNT(1) / COUNT(DISTINCT l.session) AS count_per_user
FROM action_log AS l
CROSS JOIN
stats AS s
GROUP BY l.action, s.total_uu