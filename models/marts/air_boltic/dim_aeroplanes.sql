with
source as (
    select
        airplane_id,
        model_id       
    from {{ ref('stg_aeroplanes') }}

)

select * from source