
with

statuses as (
    select 
        distinct  order_status
  from {{ source("air_bolticw", "order") }}
)
select
    row_number() over (order by order_status) as status_id,  
    order_status
from  statuses