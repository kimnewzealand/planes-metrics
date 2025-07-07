select
    faa as faa_id,
    name as airport_name,
    lat,
    lon,
    alt,
    tz,
    dst,
    tzone
from {{ source('sky', 'airports') }}
