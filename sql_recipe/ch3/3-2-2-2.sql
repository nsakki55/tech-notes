SELECT year,
       greatest(q1, q2, q3, q4) AS greatest_sales,
       least(q1, q2, q3, q4) AS least_sales
FROM quarterly_sales
