
with 
order_data as (
    select 
        order_id,
        customer_id,
        trip_id,
        price,
        seat_no,
        status
    from {{ ref('stg_orders') }}

),
-- join the order data with the order_status model
order_with_status as (
    select 
        order_id as order_id,        
        customer_id as customer_id, 
        trip_id as trip_id,         
        price as price,          
        seat_no as seat_no,          
        stg_order_status.status_id                
    from order_data 
    left join {{ ref('stg_order_status') }}
    on order_data.status = stg_order_status.order_status
)

select * from order_with_status;
