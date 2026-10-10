# Urban Transit Analytics

Hello! This is a data analytics portfolio project focused on public transit data. The goal of this project is to analyze bus schedule adherence (On-Time Performance), identify delayed routes, and find common reasons for transit delays using synthetic data.

## Project Structure

*   **`data/generate_transit_data.py`**: A Python script using `pandas` and `random` to generate a dataset of 5,000 synthetic transit logs (`transit_stop_logs.csv`).
*   **`sql/01_schema.sql`**: SQL code to create the main database table.
*   **`sql/02_data_cleaning.sql`**: SQL code to clean the data (e.g., handling missing values and checking for negative numbers).
*   **`sql/03_bottleneck_analysis.sql`**: The main SQL queries used to analyze the data. Uses fundamental SQL aggregations like `GROUP BY`, `CASE WHEN`, `SUM()`, and `AVG()`.
*   **`dashboards/power_bi_guide.md`**: A guide with DAX measures and layout ideas for building a Power BI dashboard.

## What I Analyzed (SQL Queries)

I wrote SQL queries to answer three main questions:

1.  **On-Time Performance (OTP):** What percentage of buses on each route arrive on time? (Defined as being between 1 minute early and 5 minutes late).
2.  **Severe Delays:** Which routes have the highest frequency of severe delays (buses arriving more than 5 minutes late)? 
3.  **Peak Congestion:** Which specific route stops experience the highest average delay during morning and evening rush hours?

## How to Run This Project

1.  Run the Python script to generate the data:
    ```bash
    cd data
    python generate_transit_data.py
    ```
2.  Open your SQL client (like pgAdmin or DBeaver), run `01_schema.sql` to create the table, and import the CSV file.
3.  Run the queries in `02_data_cleaning.sql` and `03_bottleneck_analysis.sql` to see the results.
4.  Open Power BI and load the CSV to build the dashboard following the guide in the `dashboards` folder.

## Skills Used
*   **Python:** Data generation, `pandas`
*   **SQL:** Data Cleaning, Aggregations (`GROUP BY`, `SUM`, `AVG`, `CASE WHEN`)
*   **Data Visualization:** Power BI, DAX
