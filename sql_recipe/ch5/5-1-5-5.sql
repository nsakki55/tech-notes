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

SELECT CASE has_purchase
WHEN 1 THEN 'purchase' WHEN 0 THEN 'not purchase' ELSE 'any'
END AS has_purchase,

CASE has_review
WHEN 1 THEN 'review' WHEN 0 THEN 'not review' ELSE 'any'
END AS has_review,

CASE has_favorite
WHEN 1 THEN 'favorite' WHEN 0 THEN 'not favorite' ELSE 'any'
END AS has_favorite,

users,
100.0 * users / NULLIF(SUM(CASE WHEN has_purchase IS NULL
AND has_review IS NULL
AND has_favorite IS NULL
THEN users ELSE 0 END) OVER(), 0) AS ratio
FROM action_venn_diagram
ORDER BY has_purchase, has_review, has_favorite

