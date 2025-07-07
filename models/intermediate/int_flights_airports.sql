with

flights as (

    select * from {{ ref( 'stg_flights') }}

),

airports_origin as (

    select * from {{ ref( 'stg_airports') }}

),

airports_dest as (

    select * from {{ ref( 'stg_airports') }}

)

select
    flights.flights_id,
    flights.weather_id,
    flights.sched_dep_date_time,
    flights.dep_date_time,
    flights.dep_delay,
    flights.sched_arr_date_time,
    flights.arr_date_time,
    flights.arr_delay,
    flights.carrier,
    flights.flight,
    flights.tailnum_id,
    flights.origin,
    flights.dest,
    flights.air_time,
    flights.distance,
    flights.airline,
    flights.callsign,
    flights.primary_hub,
    airports_origin.faa_id as origin_faa_id,
    airports_origin.airport_name as origin_airport_name,
    airports_origin.lat as origin_lat,
    airports_origin.lon as origin_lon,
    airports_origin.alt as origin_alt,
    airports_origin.tz as origin_tz,
    airports_origin.dst as origin_dst,
    airports_origin.tzone as origin_tzone,
    airports_dest.faa_id as dest_faa_id,
    airports_dest.airport_name as dest_airport_name,
    airports_dest.lat as dest_lat,
    airports_dest.lon as dest_lon,
    airports_dest.alt as dest_alt,
    airports_dest.tz as dest_tz,
    airports_dest.dst as dest_dst,
    airports_dest.tzone as dest_tzone
from flights
left join airports_origin on flights.origin = airports_origin.faa_id
left join airports_dest on flights.dest = airports_dest.faa_id
