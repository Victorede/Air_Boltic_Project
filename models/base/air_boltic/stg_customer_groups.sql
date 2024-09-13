{{
    config(
        partition_by=["customer_group_id"]
    )
}}

with
source as (
    select
        cast("ID" as int) as customer_group_id,
        cast("Type" as string) as type,
        cast("Name" as string) as name,
        cast("Registry number" as string) as registry_number,
    from {{ source("air_boltic", "customer_group") }}
     {{ add_rows_limit() }}
       
)

select * from source
