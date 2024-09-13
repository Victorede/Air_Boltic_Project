with
source as (
    select
        customer_id,
        name,
        customer_group_id,
        email --contains Pii, based on data governance not all department will be allowed to view this column
    from {{ ref('stg_customers') }}

)

select * from source