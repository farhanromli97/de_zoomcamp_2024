with 

source as (

    select * from {{ source('staging', 'fhv_tripdata') }}

)

    select
        dispatching_base_num,
        pickup_datetime,
        dropoff_datetime,
        pulocationid,
        dolocationid,
        sr_flag,
        affiliated_base_number

    from source
    where extract(YEAR FROM cast(pickup_datetime as timestamp)) = 2019

