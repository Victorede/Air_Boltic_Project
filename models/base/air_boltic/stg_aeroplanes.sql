
with
source as (
    select
        cast("Airplane ID" as int) as airplane_id,
        cast("Airplane Model" as string) as model_id 
    from {{ source("air_boltic", "aeroplane") }}
     {{ add_rows_limit() }}
       
)

select * from source
