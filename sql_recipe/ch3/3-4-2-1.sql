SELECT m.category_id,
       m.name,
       s.sales,
       r.product_id AS sale_product
FROM mst_categories AS m
         JOIN
     category_sales AS s
     ON m.category_id = s.category_id
         JOIN
     product_sale_ranking AS r
     ON m.category_id = r.category_id