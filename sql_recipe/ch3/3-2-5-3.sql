SELECT user_id,
       CURRENT_DATE                                                   AS today,
       register_stamp::date                                           AS register_date,
       birth_date::date                                               AS birth_date
       --EXTRACT(YEAR FROM age(birth_date::date))                       AS current_age,
       --EXTRACT(YEAR FROM age(register_stamp::date, birth_date::date)) AS register_age
FROM mst_users_with_birthday