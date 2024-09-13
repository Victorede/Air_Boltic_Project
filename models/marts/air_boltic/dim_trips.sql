with
source as (
    select
        trip_id,
        origin_city,
        destination_city,
        airplane_id,
        start_timestamp,
        end_timestamp  
    from {{ ref('stg_aeroplane_models') }}

)

select * from source