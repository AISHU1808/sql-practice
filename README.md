# Corporate Layoffs Data Cleaning & Analysis (SQL)

## Project Overview
This project contains a comprehensive SQL script dedicated to cleaning, standardizing, and analyzing a multi-industry corporate layoffs dataset. The objective was to transform raw, inconsistent data into a structured and clean state suitable for reliable business intelligence and reporting.

The project is split into two core phases: **Data Cleaning & Standardization** and **Exploratory Data Analysis (EDA)**.

---

## Technical SQL Skills Demonstrated

### 1. Data Cleaning Techniques
* **Duplicate Removal:** Employed `ROW_NUMBER() OVER(PARTITION BY...)` window functions within a staging table schema to isolate and cleanly purge duplicate row records.
* **Text Standardization:** Used `TRIM()` and `TRIM(TRAILING '.' FROM ...)` to fix whitespace issues and clean country names (e.g., standardizing variations of the United States).
* **Industry Consolidation:** Grouped overlapping labels using `LIKE` operations (e.g., regularizing all text variants into a standard `'Crypto'` industry segment).
* **Type Conversion:** Used `STR_TO_DATE()` to change text-based dates into structural `DATE` types, followed by `ALTER TABLE` modifications.
* **Null Value Resolution:** Handled missing or empty records by executing self-joins (`JOIN`) to copy missing data across matching company profiles.
* **Schema Maintenance:** Dropped unneeded helper indexing columns using `ALTER TABLE ... DROP COLUMN`.

### 2. Exploratory Data Analysis (EDA)
* **Aggregations:** Calculated comprehensive volume levels using `SUM()`, `COUNT()`, and `MAX()`.
* **Business Stratification:** Grouped global metrics dynamically by Company, Industry, Country, and Calendar Year using `GROUP BY` and `ORDER BY`.
* **Advanced CTEs:** Designed complex logical loops utilizing **Common Table Expressions (CTEs)** to determine step-by-step monthly rolling totals for layoffs.

---

## Core Business Insights Uncovered
1. **Industry Impacts:** Particular segments (such as Consumer and Retail markets) experienced disproportionately high volumes of employee workforce adjustments.
2. **Geographic Distribution:** The analysis clearly identifies specific countries as leading hubs for workforce changes during the documented timeline.
3. **Temporal Trends:** Grouping data chronologically highlights distinct spikes and peak periods in layoff numbers throughout the year.

---

## How to Explore the Code
1. Open the file `layoffs_project.sql` in this repository to read the full database script.
2. The queries can be copied directly and executed inside SQL platforms (such as MySQL or PostgreSQL) to duplicate the processing pipeline.
