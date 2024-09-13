{{
    config(
        partition_by=["customer_group_id"]
    )
}}

with
source as (
    select
        cast("Customer ID" as int) as customer_id,
        cast("Name" as string) as name,
        cast("Customer Group ID" as int) as customer_group_id,
        cast("Email" as string) as email
    from {{ source("air_boltic", "customer") }}
       
)

select * from source
