with
source as (
    select
        cast("Trip ID" as int) as trip_id,
        cast("Origin City" as string) as origin_city,
        cast("Destination City" as string) as destination_city,
        cast("Airplane ID" as int) as airplane_id,
        cast("Start Timestamp" as timestamp) as start_timestamp, 
        cast("End Timestamp" as timestamp) as end_timestamp
    from {{ source("air_bolticw", "order") }}
     {{ add_rows_limit() }}
)

select * from source