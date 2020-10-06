SELECT user_id,
       register_stamp::timestamp                       AS register_stamp,
       dateadd(hour, 1, register_stamp::timestamp)     AS after_1_hour,
       dateadd(minute, -30, register_stamp::timestamp) AS after_30_minute,
       register_stamp::date                            AS register_date,
       dateadd(day, 1, register_stamp::date)           AS after_1_day,
       dateadd(month, -1, register_stamp::date)        AS before_1_month

FROM mst_users_with_birthday


