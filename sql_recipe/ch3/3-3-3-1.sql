SELECT dt,
       MAX(CASE WHEN indicator = 'impressions' THEN val END) AS impressions,
       MAX(CASE WHEN indicator = 'sessions' THEN val END)    AS sessions,
       MAX(CASE WHEN indicator = 'users' THEN val END)       AS users
FROM daily_kpi
GROUP BY dt
ORDER BY dt