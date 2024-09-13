with
source as (
    select
       cast("Order ID" as int) as order_id,
        cast("Customer ID" as string) as customer_id,
        cast("Trip ID" as int) as trip_id,
        cast("Price (EUR)" as double) as price,
        cast("Seat No" as int) as seat_no, 
        cast("Status" as string) as status
    from {{ source("air_bolticw", "order") }}
)

select * from source