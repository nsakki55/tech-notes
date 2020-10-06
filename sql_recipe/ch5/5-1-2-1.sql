WITH mst_users_with_int_birth_date AS (
    SELECT *,
           20170101                                                        AS int_specific_date,
           CAST(replace(substring(birth_date, 1, 10), '-', '') AS integer) AS int_birth_date
    FROM mst_users
),
     mst_users_with_age AS (
         SELECT *,
                floor((int_specific_date - int_birth_date) / 10000) AS age
         FROM mst_users_with_int_birth_date
     )

SELECT user_id,
       sex,
       birth_date,
       age
FROM mst_users_with_age