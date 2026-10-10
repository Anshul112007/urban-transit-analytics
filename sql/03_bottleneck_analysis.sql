-- 1. On-Time Performance (OTP %) per route
-- Definition: On-Time means delay is between -60s (1 min early) and +300s (5 min late)
SELECT 
    route_id,
    COUNT(*) as total_stops,
    SUM(CASE WHEN delay_seconds BETWEEN -60 AND 300 THEN 1 ELSE 0 END) as on_time_stops,
    ROUND((SUM(CASE WHEN delay_seconds BETWEEN -60 AND 300 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) as otp_percentage
FROM transit_data
GROUP BY route_id
ORDER BY otp_percentage ASC;


-- 2. Most Frequently Delayed Routes
-- Identifying routes that have the highest percentage of severe delays (over 5 minutes)
SELECT 
    route_id,
    COUNT(*) as total_stops,
    SUM(CASE WHEN delay_seconds > 300 THEN 1 ELSE 0 END) as severe_delays,
    ROUND((SUM(CASE WHEN delay_seconds > 300 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) as severe_delay_percentage
FROM transit_data
GROUP BY route_id
ORDER BY severe_delay_percentage DESC;


-- 3. Top 5 Congested Stops (Peak Commuting Hours)
-- Finding the stops with the highest average delay during morning and evening rush hours
SELECT 
    route_id,
    stop_id,
    COUNT(*) as num_peak_trips,
    SUM(delay_seconds) as total_delay_seconds,
    ROUND(AVG(delay_seconds), 2) as average_delay_seconds
FROM transit_data
-- Filter for peak hours (7 AM - 9 AM and 4 PM - 6 PM)
WHERE EXTRACT(HOUR FROM scheduled_arrival) IN (7, 8, 16, 17)
GROUP BY route_id, stop_id
ORDER BY average_delay_seconds DESC
LIMIT 5;
