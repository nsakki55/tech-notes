SELECT *
FROM (SELECT category,
             product_id,
             score,
             ROW_NUMBER() OVER (PARTITION BY category ORDER BY score DESC) AS rank
      FROM popular_products)
         AS popular_products_with_rank
WHERE rank <= 2
ORDER BY category, rank