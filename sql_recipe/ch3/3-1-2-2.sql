SELECT stamp,
url,
regexp_replace(regexp_substr(url, '//[^/]+[^?#]+'), '//[^/]+', '') AS path,
regexp_replace(regexp_substr(url, 'id=[^&]*'), 'id=', '') AS id
FROM access_log