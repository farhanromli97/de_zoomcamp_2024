CREATE MATERIALIZED VIEW diff_two_zones AS SELECT taxi_zone_pu.Zone AS pickup_zone, taxi_zone_do.Zone AS dropoff_zone, avg(tpep_dropoff_datetime - tpep_pickup_datetime) avg_time_diff, min(tpep_dropoff_datetime - tpep_pickup_datetime) min_time_diff, max(tpep_dropoff_datetime - tpep_pickup_datetime) max_time_diff, count(*) trip_count
FROM trip_data
INNER JOIN taxi_zone as taxi_zone_pu
        ON trip_data.PULocationID = taxi_zone_pu.location_id
INNER JOIN taxi_zone as taxi_zone_do
        ON trip_data.DOLocationID = taxi_zone_do.location_id
WHERE taxi_zone_pu.Zone != taxi_zone_do.Zone
GROUP by taxi_zone_pu.Zone, taxi_zone_do.Zone;

WITH z AS (SELECT max(avg_time_diff) max_avg from diff_two_zones)
SELECT d.*
FROM diff_two_zones d, z
WHERE d.avg_time_diff = z.max_avg;


CREATE MATERIALIZED VIEW busiest_zones_17_hour AS 
WITH t AS (SELECT max(tpep_pickup_datetime) latest_pickup_datetime
FROM trip_data)
SELECT
    taxi_zone.Zone AS pickup_zone,
    count(*) AS last_17_hour_pickup_cnt
FROM
    t, trip_data
        INNER JOIN taxi_zone
            ON trip_data.pulocationid = taxi_zone.location_id
WHERE
    trip_data.tpep_pickup_datetime >= (t.latest_pickup_datetime - (17 * INTERVAL '1' HOUR))
GROUP BY
    taxi_zone.Zone
ORDER BY last_17_hour_pickup_cnt DESC
    LIMIT 3;


