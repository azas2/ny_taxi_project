{{
    config(
        materialized='view'
    )
}}

with tripdata as 
(
  select *, 
         row_number() over(partition by vendorid, lpep_pickup_datetime) as rn
  from {{ source('staging','green_tripdata_2019') }}
  where vendorid is not null 
)
select 
    {{ dbt_utils.generate_surrogate_key(['vendorid', 'lpep_pickup_datetime']) }} as tripid,
    SAFE_CAST(vendorid AS INT64) as vendorid,
    SAFE_CAST(ratecodeid AS INT64) as ratecodeid,
    SAFE_CAST(pulocationid AS INT64) as pickup_locationid,
    SAFE_CAST(dolocationid AS INT64) as dropoff_locationid,
    SAFE_CAST(lpep_pickup_datetime AS TIMESTAMP) as pickup_datetime,
    SAFE_CAST(lpep_dropoff_datetime AS TIMESTAMP) as dropoff_datetime,
    store_and_fwd_flag,
    SAFE_CAST(passenger_count AS INT64) as passenger_count,
    SAFE_CAST(trip_distance AS NUMERIC) as trip_distance,
    SAFE_CAST(trip_type AS INT64) as trip_type,
    SAFE_CAST(fare_amount AS NUMERIC) as fare_amount,
    SAFE_CAST(extra AS NUMERIC) as extra,
    SAFE_CAST(mta_tax AS NUMERIC) as mta_tax,
    SAFE_CAST(tip_amount AS NUMERIC) as tip_amount,
    SAFE_CAST(tolls_amount AS NUMERIC) as tolls_amount,
    SAFE_CAST(ehail_fee AS NUMERIC) as ehail_fee,
    SAFE_CAST(improvement_surcharge AS NUMERIC) as improvement_surcharge,
    SAFE_CAST(total_amount AS NUMERIC) as total_amount,
    COALESCE(SAFE_CAST(payment_type AS INT64), 0) as payment_type,
    {{ get_payment_discription("payment_type") }} as payment_type_description
from tripdata
where rn = 1

{% if var('is_test_run', default=true) %}
LIMIT 100
{% endif %}
