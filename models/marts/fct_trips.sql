-- select
--     vendor_id,
--     pickup_datetime,
--     passenger_count,
--     count(*) as occurences
-- from {{ ref('int_trips_unioned')}}
-- group by 1, 2, 3
-- having count(*) > 1

-- with deduplicated_trips as (
--     select * from {{ ref('int_trips_unioned')}}
-- )

select * from {{ ref('int_trips_unioned')}}

-- TODO Try unioned file it caused too many bytes 