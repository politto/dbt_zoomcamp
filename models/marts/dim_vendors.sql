with trips_unioned as (
    select * from {{ ref('int_trips_unioned')}}
),

vendors as (
    select distinct vendor_id,
    -- bad approach use macros instead
    -- CASE
    --     WHEN vendor_id = 1 THEN 'Creative Mobile Technologies, LLC'
    --     WHEN vendor_id = 2 THEN 'VeriFone Inc.'
    --     WHEN vendor_id = 4 THEN 'Unknown Vendor'
    -- END AS vendor_name

    -- use this..
        {{ get_vendor_names('vendor_id')}} as vendor_name
    from trips_unioned
)

select * from vendors