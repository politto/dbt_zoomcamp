with taxi_price_lookup as (
    select * from {{ ref('taxi_price_lookup')}}
),

renamed as (
    select 
        payment_type,
        payment_name
    from taxi_price_lookup
)

select * from renamed