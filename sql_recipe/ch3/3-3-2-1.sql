SELECT product_id,
       score,
       ROW_NUMBER() OVER (ORDER BY score DESC)        AS row,
       RANK() OVER (ORDER BY score DESC)              AS rank,
       DENSE_RANK() OVER (ORDER BY score DESC)        AS dense_rank,
       LAG(product_id) OVER (ORDER BY score DESC)     AS lag1,
       LAG(product_id, 2) OVER (ORDER BY score DESC)  AS lag2,
       LEAD(product_id) OVER (ORDER BY score ASC)    AS lead1,
       LEAD(product_id, 2) OVER (ORDER BY score ASC) AS lead2
FROM popular_products