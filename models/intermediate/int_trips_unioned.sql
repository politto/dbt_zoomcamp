
{{
  config(
    materialized='table'
  )
}}

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

-- select * from trips_unioned
select distinct vendor_id from trips_unioned

-- deduplicated_trips as (
--     select *,
--         row_number() over(
--             partition by vendor_id, pickup_datetime, passenger_count
--             order by pickup_datetime
--         ) as rn
--     from trips_unioned
-- )

-- select *, except(rn)
-- from deduplicated_trips
-- where rn = 1