-- Uber Supply–Demand Gap Analysis
-- MySQL Workbench script. Execute sections in order.
CREATE DATABASE IF NOT EXISTS uber_supply_demand;
USE uber_supply_demand;

-- Table columns match the six columns in the supplied CSV.
CREATE TABLE IF NOT EXISTS uber_requests (
    request_id INT PRIMARY KEY,
    pickup_point VARCHAR(20),
    driver_id INT NULL,
    status VARCHAR(30),
    request_timestamp DATETIME,
    drop_timestamp DATETIME NULL
);

-- IMPORT NOTE:
-- Use MySQL Workbench: Schemas > uber_supply_demand > Tables > right-click > Table Data Import Wizard.
-- Choose the raw "Uber Request Data.csv", then choose existing table uber_requests.
-- The source has missing values for driver_id and drop_timestamp; import wizard should map them to NULL.
-- If the table is already populated, do not import again without clearing it first.

-- 1. Total requests
SELECT COUNT(*) AS total_requests FROM uber_requests;

-- 2. Status distribution
SELECT status, COUNT(*) AS requests,
       ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM uber_requests), 2) AS pct_of_requests
FROM uber_requests GROUP BY status ORDER BY requests DESC;

-- 3. Requests by pickup point
SELECT pickup_point, COUNT(*) AS requests
FROM uber_requests GROUP BY pickup_point ORDER BY requests DESC;

-- 4. Status by pickup point
SELECT pickup_point, status, COUNT(*) AS requests
FROM uber_requests GROUP BY pickup_point, status
ORDER BY pickup_point, requests DESC;

-- 5. Requests by hour
SELECT HOUR(request_timestamp) AS request_hour, COUNT(*) AS requests
FROM uber_requests
WHERE request_timestamp IS NOT NULL
GROUP BY HOUR(request_timestamp) ORDER BY request_hour;

-- 6. Status by time slot
SELECT CASE
         WHEN HOUR(request_timestamp) < 5 THEN 'Early Morning'
         WHEN HOUR(request_timestamp) < 12 THEN 'Morning'
         WHEN HOUR(request_timestamp) < 17 THEN 'Afternoon'
         WHEN HOUR(request_timestamp) < 21 THEN 'Evening'
         ELSE 'Night'
       END AS time_slot,
       status, COUNT(*) AS requests
FROM uber_requests
WHERE request_timestamp IS NOT NULL
GROUP BY time_slot, status
ORDER BY FIELD(time_slot,'Early Morning','Morning','Afternoon','Evening','Night'), status;

-- 7. Cancellation rate by pickup point
SELECT pickup_point,
       COUNT(*) AS total_requests,
       SUM(status = 'Cancelled') AS cancelled_requests,
       ROUND(100.0 * SUM(status = 'Cancelled') / COUNT(*), 2) AS cancellation_rate_pct
FROM uber_requests GROUP BY pickup_point;

-- 8. No-car availability rate by pickup point
SELECT pickup_point,
       COUNT(*) AS total_requests,
       SUM(status = 'No Cars Available') AS no_car_requests,
       ROUND(100.0 * SUM(status = 'No Cars Available') / COUNT(*), 2) AS no_car_rate_pct
FROM uber_requests GROUP BY pickup_point;

-- 9. Completed trips by hour
SELECT HOUR(request_timestamp) AS request_hour, COUNT(*) AS completed_trips
FROM uber_requests
WHERE status = 'Trip Completed' AND request_timestamp IS NOT NULL
GROUP BY HOUR(request_timestamp) ORDER BY request_hour;

-- 10. Mean/median trip duration (MySQL 8.0.2+ supports PERCENTILE_CONT)
SELECT ROUND(AVG(TIMESTAMPDIFF(MINUTE, request_timestamp, drop_timestamp)), 2) AS avg_trip_minutes
FROM uber_requests
WHERE status = 'Trip Completed'
  AND request_timestamp IS NOT NULL AND drop_timestamp IS NOT NULL
  AND drop_timestamp >= request_timestamp;

-- 11. Request count by day of week
SELECT DAYNAME(request_timestamp) AS request_day, COUNT(*) AS requests
FROM uber_requests WHERE request_timestamp IS NOT NULL
GROUP BY DAYOFWEEK(request_timestamp), DAYNAME(request_timestamp)
ORDER BY DAYOFWEEK(request_timestamp);

-- 12. Supply–demand gap proxy: unsuccessful requests (cancelled + no cars) by time slot
SELECT CASE
         WHEN HOUR(request_timestamp) < 5 THEN 'Early Morning'
         WHEN HOUR(request_timestamp) < 12 THEN 'Morning'
         WHEN HOUR(request_timestamp) < 17 THEN 'Afternoon'
         WHEN HOUR(request_timestamp) < 21 THEN 'Evening'
         ELSE 'Night'
       END AS time_slot,
       COUNT(*) AS total_requests,
       SUM(status = 'Trip Completed') AS completed,
       SUM(status IN ('Cancelled','No Cars Available')) AS unsuccessful,
       ROUND(100.0 * SUM(status IN ('Cancelled','No Cars Available')) / COUNT(*), 2) AS unsuccessful_pct
FROM uber_requests WHERE request_timestamp IS NOT NULL
GROUP BY time_slot
ORDER BY FIELD(time_slot,'Early Morning','Morning','Afternoon','Evening','Night');
