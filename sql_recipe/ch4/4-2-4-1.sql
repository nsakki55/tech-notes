WITH stats AS (
    SELECT MAX(price)              AS max_price,
           MIN(price)              AS min_price,
           MAX(price) - MIN(price) AS range_price,
           10                      AS bucket_num
    FROM purchase_detail_log)
SELECT *
FROM stats