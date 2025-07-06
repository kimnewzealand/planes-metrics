SELECT
    TAILNUM,
    YEAR,
    TYPE,
    MANUFACTURER,
    MODEL,
    ENGINES,
    SEATS,
    SPEED,
    ENGINE
FROM {{ source('sky', 'planes') }}
