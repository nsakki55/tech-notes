WITH stats AS (
    SELECT MAX(price)              AS max_price,
           MIN(price)              AS min_price,
           MAX(price) - MIN(price) AS range_price,
           10                      AS bucket_num
    FROM purchase_detail_log),

     purchase_log_with_bucket AS (
         SELECT price,
                min_price,
                price - min_price              AS diff,
                1.0 * range_price / bucket_num AS bucket_range,
                FLOOR(
                            1.0 * (price - min_price)
                            / (1.0 * range_price / bucket_num)
                    ) + 1                      AS bucket
         FROM purchase_detail_log,
              stats
     )

SELECT bucket,
       min_price + bucket_range * (bucket - 1) AS lower_limit,
       min_price + bucket_range * bucket       AS upper_limit,
       COUNT(price)                            AS total_amount
FROM purchase_log_with_bucket
GROUP BY bucket, min_price, bucket_range
ORDER BY bucket