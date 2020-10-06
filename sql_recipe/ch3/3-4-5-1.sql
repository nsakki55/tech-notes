WITH mst_device AS (
    SELECT 1 AS device_id, 'PC' AS device_name
    UNION ALL
    SELECT 2 AS device_id, 'SP' AS device_name
    UNION ALL
    SELECT 3 AS device_id, 'アプリ' AS device_name
)
SELECT *
FROM mst_device