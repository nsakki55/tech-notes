SELECT dt,
       ad_id,
       CASE WHEN impressions > 0 THEN 100.0 * clicks / impressions
       END AS ctr_as_percent_by_case,
        100.0 * clicks / NULLIF(impressions, 0) AS ctr_as_percent_by_null
FROM advertising_stats
ORDER BY dt, ad_id