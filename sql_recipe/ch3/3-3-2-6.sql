SELECT DISTINCT
category,
FIRST_VALUE(product_id)
OVER(PARTITION BY category ORDER BY score DESC
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING ) AS product_id
FROM popular_products