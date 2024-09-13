-- Parse the JSON data into a structured map
with
 parsed_json as (
    select
        from_json(json_data, 'map<string,map<string,struct<max_seats:int,max_weight:int,max_distance:int,engine_type:string>>>') AS data
    from {{ source("air_boltic_raw", "raw_aeroplane") }}
),

-- Extract the manufacturers and their respective airplane models
exploded_manufacturers as (
    select 
        explode(map_keys(data)) as manufacturer,  
        explode(map_values(data)) as model_details 
    from parsed_json
),

--  Flatten the nested airplane model details for each manufacturer
flattened_models as (
    select 
        manufacturer,  
        model_details['key'] as model_id, 
        model_details['value']['max_seats'] as max_seats, 
        model_details['value']['max_weight'] as max_weight, 
        model_details['value']['max_distance'] as max_distance, 
        model_details['value']['engine_type'] as engine_type 
    from exploded_manufacturers
)


select * from flattened_models;
