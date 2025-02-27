SELECT ip,
       CAST(split_part(ip, '.', 1) AS integer) AS ip_part_1,
       CAST(split_part(ip, '.', 2) AS integer) AS ip_part_2,
       CAST(split_part(ip, '.', 3) AS integer) AS ip_part_3,
       CAST(split_part(ip, '.', 4) AS integer) AS ip_part_4
FROM (SELECT '192.168.0.1' AS ip) AS t