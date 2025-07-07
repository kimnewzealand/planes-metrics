select
    tailnum as tailnum_id,
    year,
    type,
    manufacturer,
    model,
    engines,
    seats,
    speed,
    engine
from {{ source('sky', 'planes') }}
