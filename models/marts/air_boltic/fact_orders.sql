with
source as (
    select
        order_id,
        customer_id,
        trip_id,
        price,
        seat_no,
        status_id  
    from {{ ref('stg_aeroplane_models') }}

)

select * from source