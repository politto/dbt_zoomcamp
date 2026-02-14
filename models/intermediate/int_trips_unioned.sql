with green_tripdata as (
    --way to reference if no source provided in sources.yml file
    select * from {{ref('stg_green_tripdata')}}
),

yellow_tripdata as (
    --way to reference if no source provided in sources.yml file
    select * from {{ref('stg_yellow_tripdata')}}
),

trips_unioned as (
    select * from green_tripdata
    union all
    select * from yellow_tripdata
)

select * from trips_unioned