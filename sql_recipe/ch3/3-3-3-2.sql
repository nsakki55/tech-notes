SELECT
purchase_id,
       listagg(product_id, ',') AS product_ids,
       SUM(price) AS amount
FROM purchase_detail_log
GROUP BY purchase_id
ORDER BY purchase_id