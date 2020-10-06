SELECT stamp,
       regexp_replace(regexp_substr(referrer, 'https?://[^/]*'), 'https?://', '')
           AS referrer_host
FROM access_log
