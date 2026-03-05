{{
  config(
    materialized='incremental',
    unique_key='trip_id',
    on_schema_change='append_new_columns'
  )
}}

with green_tripdata as (
    select * from {{ ref('stg_green_tripdata') }}
    where pickup_datetime >= '2019-01-01' and pickup_datetime < '2019-02-01'
    -- Update these dates for each "chunk" run
),

yellow_tripdata as (
    select * from {{ ref('stg_yellow_tripdata') }}
    where pickup_datetime >= '2019-01-01' and pickup_datetime < '2019-02-01'
),

trips_unioned as (
    select 
        -- Create a unique ID for the merge to work
        md5(cast(concat(vendor_id, pickup_datetime) as string)) as trip_id,
        * from green_tripdata
    union all
    select 
        md5(cast(concat(vendor_id, pickup_datetime) as string)) as trip_id,
        * from yellow_tripdata
),

deduplicated_trips as (
    select *,
        row_number() over(
            partition by vendor_id, pickup_datetime, passenger_count
            order by pickup_datetime
        ) as rn
    from trips_unioned
)

select * except(rn) from deduplicated_trips where rn = 1