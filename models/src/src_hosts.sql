WITH raw_hosts AS (
    Select * from AIRBNB.RAW.RAW_HOSTS
)

SELECT
    ID AS HOST_ID,
    NAME AS HOST_NAME,
    IS_SUPERHOST,
    CREATED_AT,
    UPDATED_AT
FROM
    raw_hosts