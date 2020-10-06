SELECT
user_id,
CURRENT_DATE AS today,
register_stamp::date AS register_date,
birth_date::date AS birth_date,
datediff(year, birth_date::date, CURRENT_DATE ),
datediff(year, birth_date::date, register_stamp::date)
FROM mst_users_with_birthday