# Power BI Dashboard Guide

This guide explains how to build a basic 2-page Power BI dashboard for the urban transit project. It's a great project for a junior data analyst portfolio!

## Page 1: Transit Overview

**Goal:** Give a quick summary of the transit network's performance.

**Visuals to create:**
1. **KPI Cards (Top of page):**
   * **Total Trips:** Just do a count of `trip_id`.
   * **Average Delay (Minutes):** Create a simple measure.
   * **Overall OTP %:** Calculate the percentage of on-time buses.

2. **Bar Chart: OTP % by Route**
   * **X-Axis:** `route_id`
   * **Y-Axis:** OTP % (Measure)
   * This shows which routes are doing well and which are struggling.

3. **Donut Chart: Delay Reasons**
   * **Legend:** `delay_reason`
   * **Values:** Count of `trip_id`
   * Filter out "On-Time" so we only see what causes delays.

## Page 2: Congestion & Corridors

**Goal:** Look deeper into where delays happen and bus bunching.

**Visuals to create:**
1. **Line Chart: Average Delay by Hour of Day**
   * Create a column for the hour of the day from `scheduled_arrival`.
   * **X-Axis:** Hour of Day
   * **Y-Axis:** Average Delay
   * Shows when rush hour hits the hardest.

2. **Table: Top 5 Worst Stops**
   * Put `route_id`, `stop_id`, and `Total Delay` in a table.
   * Sort by Total Delay descending.

## Helpful DAX Measures

Here are some simple DAX formulas you can copy/paste into Power BI:

```dax
// Convert seconds to minutes for easier reading
Average Delay (Mins) = AVERAGE(transit_data[delay_seconds]) / 60

// Calculate how many stops were on time (between -60s and 300s)
On Time Count = 
CALCULATE(
    COUNT(transit_data[trip_id]),
    transit_data[delay_seconds] >= -60,
    transit_data[delay_seconds] <= 300
)

// Calculate the percentage of on-time stops
OTP % = [On Time Count] / COUNT(transit_data[trip_id])

// Find the average passenger load
Average Passengers = AVERAGE(transit_data[passenger_load])
```

## Tips for your Portfolio
* Keep the colors clean (use green for on-time, red for delayed).
* Make sure all your charts have clear, readable titles.
* Add a text box explaining *why* this data is useful (e.g., "Helps dispatchers know which routes need more buses").
