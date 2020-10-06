SELECT stamp,
       substring(stamp, 1, 4)  AS year,
       substring(stamp, 6, 2)  AS month,
       substring(stamp, 9, 2)  AS day,
       substring(stamp, 12, 2)  AS hour
FROM (SELECT CAST('2016-01-30 12:00:00' AS text) AS stamp) AS t