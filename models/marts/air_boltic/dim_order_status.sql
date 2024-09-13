with
source as (
    select
        status_id,
        order_status
    from {{ ref('stg_order_status') }}

)

select * from source