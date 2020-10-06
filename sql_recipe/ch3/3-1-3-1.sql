SELECT stamp,
       url,
       split_part(regexp_replace(
                          regexp_substr(url, '//[^/]+[^?#]+'), '//[^/]+', ''), '/', 2) AS path1,
       split_part(regexp_replace(
                          regexp_substr(url, '//[^/]+[^?#]+'), '//[^/]+', ''), '/', 3) AS path2
FROM access_log