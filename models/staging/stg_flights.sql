with

source as (

    select * from {{ source('sky', 'flights') }}

)

,

flights_with_hour_minutes as (

    select
        year,
        month,
        day,
        dep_time,
        sched_dep_time,
        dep_delay,
        arr_time,
        sched_arr_time,
        arr_delay,
        carrier,
        flight,
        origin,
        dest,
        air_time,
        distance,
        hour,
        minute,
        time_hour,
        airline,
        callsign,
        primary_hub,
        tailnum as tailnum_id,
        cast(right(cast(dep_time as varchar(100)), 2) as int)
            as dep_minute,
        cast(right(cast(arr_time as varchar(100)), 2) as int)
            as arr_minute,
        cast(right(cast(sched_arr_time as varchar(100)), 2) as int)
            as sched_arr_minute,
        case
            when len(dep_time) = 3
                then cast(left(cast(dep_time as varchar(100)), 1) as int)
            when len(dep_time) = 4
                then cast(left(cast(dep_time as varchar(100)), 2) as int)
        end as dep_hour,
        case
            when len(arr_time) = 3
                then cast(left(cast(arr_time as varchar(100)), 1) as int)
            when len(arr_time) = 4
                then cast(left(cast(arr_time as varchar(100)), 2) as int)
        end as arr_hour,
        case
            when len(sched_arr_time) = 3
                then cast(left(cast(sched_arr_time as varchar(100)), 1) as int)
            when len(sched_arr_time) = 4
                then cast(left(cast(sched_arr_time as varchar(100)), 2) as int)
        end as sched_arr_hour
    from source
),

flights_with_times as (
    select
        year,
        month,
        day,
        dep_time,
        sched_dep_time,
        dep_delay,
        arr_time,
        sched_arr_time,
        arr_delay,
        carrier,
        flight,
        tailnum_id,
        origin,
        dest,
        air_time,
        distance,
        hour,
        minute,
        time_hour,
        airline,
        callsign,
        primary_hub,
        timestamp_from_parts(year, month, day, hour, minute, 0)
            as sched_dep_date_time,
        timestamp_from_parts(year, month, day, dep_hour, dep_minute, 0)
            as dep_date_time,
        timestamp_from_parts(
            year, month, day, sched_arr_hour, sched_arr_minute, 0
        ) as sched_arr_date_time,
        timestamp_from_parts(year, month, day, arr_hour, arr_minute, 0)
            as arr_date_time
    from flights_with_hour_minutes
)

select
    *,
    concat(carrier, '~', flight, '~', cast(sched_dep_date_time as string))
        as flights_id,
    concat(origin, '~', cast(sched_dep_date_time as string))
        as weather_id
from flights_with_times
