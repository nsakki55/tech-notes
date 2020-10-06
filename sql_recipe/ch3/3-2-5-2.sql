SELECT user_id,
       CURRENT_DATE                        AS today,
       register_stamp::date                AS register_date,
       CURRENT_DATE - register_stamp::date AS diff_days
FROM mst_users_with_birthday