-- Basic data cleaning steps

-- 1. Remove any rows where the trip_id is missing
DELETE FROM transit_data 
WHERE trip_id IS NULL OR trip_id = '';

-- 2. Standardize missing delay reasons to 'On-Time'
UPDATE transit_data 
SET delay_reason = 'On-Time' 
WHERE delay_reason IS NULL OR delay_reason = '';

-- 3. Ensure we don't have negative passenger loads (bad data check)
UPDATE transit_data 
SET passenger_load = 0 
WHERE passenger_load < 0;

-- 4. Check for any extreme outliers in delay (e.g., over 5 hours / 18000 seconds)
-- We will just view them to decide if they should be deleted
SELECT * FROM transit_data WHERE delay_seconds > 18000;
