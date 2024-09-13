with
source as (
    select
        model_id,
        manufacturer,
        max_seats,
        max_weight,
        max_distance,
        engine_type
    from {{ ref('stg_aeroplane_models') }}

)

select * from source