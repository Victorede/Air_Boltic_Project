{{
    config(
        partition_by=["customer_group_id"]
    )
}

with
source as (
    select
        cast("ID" as int) as customer_group_id,
        cast("Type" as string) as type,
        cast("Customer Group ID" as int) as customer_group_id,
        cast("Name" as string) as name,
        cast("Registry number" as string) as name,
    from {{ source(" air_boltic", "customer_group") }}
       
)

select * from source
