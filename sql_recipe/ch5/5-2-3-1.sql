WITH repeat_interval AS (
    SELECT '01 day repeat' AS index_name, 1 AS interval_begin_date, 1 AS interval_end_date
)
        ,
     mst_actions AS (
         SELECT 'view' AS action
         UNION ALL
         SELECT 'comment' AS action
         UNION ALL
         SELECT 'follow' AS action
     ),
     mst_user_actions AS (
         SELECT u.user_id,
                u.register_date,
                a.action
         FROM mst_users AS u
                  CROSS JOIN
              mst_actions AS a
     )
SELECT *
FROM mst_user_actions
