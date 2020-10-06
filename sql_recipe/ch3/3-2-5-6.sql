SELECT user_id,
       substring(register_stamp, 1, 10) AS register_dates,
       birth_date,
       floor(
                   (CAST(replace(substring(register_stamp, 1, 10), '-', '') AS integer)
                       - CAST(replace(birth_date, '-', '') AS integer)
                       ) / 10000
           )                            AS register_age,
       floor(
                   (CAST(replace(CAST(CURRENT_DATE AS text), '-', '') AS integer)
                       - CAST(replace(birth_date, '-', '') AS integer)
                       ) / 10000
           )                            AS register_age

FROM mst_users_with_birthday