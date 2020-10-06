SELECT
category,
       product_id,
       score,
       ROW_NUMBER() OVER (PARTITION BY category ORDER BY score DESC) AS row,
       RANK() OVER (PARTITION BY category ORDER BY score DESC) AS rank,
       DENSE_RANK() OVER (PARTITION BY category ORDER BY score DESC) AS dense_rank
FROM popular_products