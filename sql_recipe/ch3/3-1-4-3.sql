SELECT stamp,
       EXTRACT(YEAR FROM stamp)  AS year,
       EXTRACT(MONTH FROM stamp) AS month,
       EXTRACT(DAY FROM stamp)   AS day,
       EXTRACT(HOUR FROM stamp)  AS hour
FROM (SELECT CAST('2016-01-30 12:00:00' AS timestamp) AS stamp) AS t