WITH
user_action_flag AS
(SELECT
user_id,
SIGN(SUM(CASE WHEN action = 'purchase' THEN 1 ELSE 0 END)) AS has_purchase,
SIGN(SUM(CASE WHEN action = 'review' THEN 1 ELSE 0 END)) AS has_review,
SIGN(SUM(CASE WHEN action = 'favorite' THEN 1 ELSE 0 END)) AS has_favorite
FROM action_log
GROUP BY user_id),
action_venn_diagram AS (
SELECT has_purchase, has_review, has_favorite, COUNT(1) AS users
FROM user_action_flag
GROUP BY has_purchase, has_review, has_favorite

UNION ALL
SELECT NULL AS has_purchase, has_review, has_favorite, COUNT(1) AS users
FROM user_action_flag
GROUP BY has_review, has_favorite

UNION ALL
SELECT has_purchase, NULL AS has_review, has_favorite, COUNT(1) AS users
FROM user_action_flag
GROUP BY has_purchase, has_favorite

UNION ALL
SELECT has_purchase, has_review, NULL AS has_favorite, COUNT(1) AS users
FROM user_action_flag
GROUP BY has_purchase, has_review

UNION ALL
SELECT NULL AS has_purchase, NULL AS has_review, has_favorite, COUNT(1) AS users
FROM user_action_flag
GROUP BY has_favorite

UNION ALL
SELECT NULL AS has_purchase, has_review, NULL AS has_favorite, COUNT(1) AS users
FROM user_action_flag
GROUP BY has_review

UNION ALL
SELECT has_purchase, NULL AS has_review, NULL AS has_favorite, COUNT(1) AS users
FROM user_action_flag
GROUP BY has_purchase

UNION ALL
SELECT NULL AS has_purchase, NULL AS has_review, NULL AS has_favorite, COUNT(1) AS users
FROM user_action_flag
    )

SELECT *
FROM action_venn_diagram
ORDER BY has_purchase, has_review, has_favorite