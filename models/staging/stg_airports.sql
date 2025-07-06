SELECT
    FAA AS FAA_CODE,
    NAME AS AIRPORT_NAME,
    LAT,
    LON,
    ALT,
    TZ,
    DST,
    TZONE
FROM {{ source('sky', 'airports') }}
