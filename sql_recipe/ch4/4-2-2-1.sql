WITH monthly_sales AS (
    SELECT category,
           SUM(price) AS amount
    FROM purchase_detail_log
    WHERE dt BETWEEN '2015-12-01' AND '2015-12-31'
    GROUP BY category
),
     sales_composition_ratio AS (
         SELECT category,
                amount,
                100.0 * amount / SUM(amount) OVER () AS composition_ratio,
                100.0 * SUM(amount) OVER (ORDER BY amount DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) /
                SUM(amount) OVER ()                  as cumulative_ratio
         FROM monthly_sales
     )

SELECT *,
       CASE
           WHEN cumulative_ratio BETWEEN 0 AND 70 THEN 'A'
           WHEN cumulative_ratio BETWEEN 70 AND 90 THEN 'B'
           WHEN cumulative_ratio BETWEEN 90 AND 100 THEN 'C'
           END AS abc_rank
FROM sales_composition_ratio
ORDER BY amount DESC