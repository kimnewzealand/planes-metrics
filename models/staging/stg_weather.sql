with

source as (

    select * from {{ source('sky', 'weather') }}

),

weather as (

    select
        origin,
        year,
        month,
        day,
        hour,
        temp,
        dewp,
        humid,
        wind_dir,
        wind_speed,
        wind_gust,
        precip,
        pressure,
        visib,
        time_hour,
        timestamp_from_parts(year, month, day, hour, 0, 0) as weather_date_time
    from source

)

select
    *,
    concat(origin, '~', cast(weather_date_time as string)) as weather_id
from weather
