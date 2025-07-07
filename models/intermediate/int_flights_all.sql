with

int_flights_airports as (

    select * from {{ ref( 'int_flights_airports') }}

),

planes as (

    select * from {{ ref( 'stg_planes') }}

),

weather as (

    select * from {{ ref( 'stg_weather') }}

)

select
    int_flights_airports.flights_id,
    int_flights_airports.weather_id,
    int_flights_airports.sched_dep_date_time,
    int_flights_airports.dep_date_time,
    int_flights_airports.dep_delay,
    int_flights_airports.sched_arr_date_time,
    int_flights_airports.arr_date_time,
    int_flights_airports.arr_delay,
    int_flights_airports.carrier,
    int_flights_airports.flight,
    int_flights_airports.tailnum_id,
    int_flights_airports.origin,
    int_flights_airports.dest,
    int_flights_airports.air_time,
    int_flights_airports.distance,
    int_flights_airports.airline,
    int_flights_airports.callsign,
    int_flights_airports.primary_hub,
    int_flights_airports.origin_faa_id,
    int_flights_airports.origin_airport_name,
    int_flights_airports.origin_lat,
    int_flights_airports.origin_lon,
    int_flights_airports.origin_alt,
    int_flights_airports.origin_tz,
    int_flights_airports.origin_dst,
    int_flights_airports.origin_tzone,
    int_flights_airports.dest_faa_id,
    int_flights_airports.dest_airport_name,
    int_flights_airports.dest_lat,
    int_flights_airports.dest_lon,
    int_flights_airports.dest_alt,
    int_flights_airports.dest_tz,
    int_flights_airports.dest_dst,
    int_flights_airports.dest_tzone,
    weather.weather_date_time,
    weather.temp,
    weather.dewp,
    weather.humid,
    weather.wind_dir,
    weather.wind_speed,
    weather.wind_gust,
    weather.precip,
    weather.pressure,
    weather.visib,
    planes.year,
    planes.type,
    planes.manufacturer,
    planes.model,
    planes.engines,
    planes.seats,
    planes.speed,
    planes.engine
from int_flights_airports
left join planes on int_flights_airports.tailnum_id = planes.tailnum_id
left join weather on int_flights_airports.weather_id = weather.weather_id
