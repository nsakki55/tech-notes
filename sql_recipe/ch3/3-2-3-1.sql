SELECT dt,
       ad_id,
       clicks / impressions         as ctr,
       100.0 * clicks / impressions AS ctr_as_percent
FROM advertising_stats
WHERE dt = '2017-04-01'
ORDER BY dt, ad_id