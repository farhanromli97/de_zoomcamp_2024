-- get count from external table
SELECT count(*) FROM `dtc-de-course-412112.ny_taxi.green_taxi_data`; 

-- get distinct PULocationID from external table
select distinct PULocationID FROM `dtc-de-course-412112.ny_taxi.green_taxi_data`;

-- get distinct PULocationID from materalised table table
select distinct PULocationID FROM `dtc-de-course-412112.ny_taxi.green_taxi_data_nonpartitioned`;  -- 6.41 MB

-- get count where fare_amount is 0
select count(*)  FROM `dtc-de-course-412112.ny_taxi.green_taxi_data_nonpartitioned`
where fare_amount = 0; 

-- get distinct PUlocationID from a partitioned, clustered table
select DISTINCT PULocationID  FROM `dtc-de-course-412112.ny_taxi.green_taxi_data_partitioned_clustered`
WHERE date(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-06-30'; -- 1.12 MB

-- get distinct PUlocationID from a nonpartitioned
select DISTINCT PULocationID  FROM `dtc-de-course-412112.ny_taxi.green_taxi_data_nonpartitioned`
WHERE date(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-06-30'; -- 12.82 MB