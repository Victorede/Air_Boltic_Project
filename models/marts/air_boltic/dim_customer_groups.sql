with
source as (
    select
        customer_group_id,
        type,
        name,
        registry_number
    from {{ ref('stg_customer_groups') }}

)

select * from source