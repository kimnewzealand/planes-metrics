SELECT
    ORIGIN,
    YEAR,
    MONTH,
    DAY,
    HOUR,
    TEMP,
    DEWP,
    HUMID,
    WIND_DIR,
    WIND_SPEED,
    WIND_GUST,
    PRECIP,
    PRESSURE,
    VISIB,
    TIME_HOUR
FROM {{ source('sky', 'weather') }}
