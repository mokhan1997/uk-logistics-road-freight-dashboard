# Methodology

## Project Approach

This project followed a structured data analysis lifecycle:

1. Business problem definition
2. Data sourcing
3. Data understanding
4. Data cleaning and preparation
5. Exploratory data analysis
6. SQLite database creation
7. SQL analysis and reporting views
8. Power BI dashboard development
9. GitHub documentation
10. Business recommendations

---

## 1. Business Problem Definition

The project was designed around a realistic transport and logistics question:

Can official UK road traffic and freight-related datasets be used to build a regional logistics intelligence dashboard?

The project was built from the perspective of an operations, logistics or transport planning team that needs better visibility of regional road network demand and traffic pressure.

---

## 2. Data Sources

The project uses official Department for Transport datasets.

The downloaded data included:

- road freight statistics tables
- regional traffic by vehicle type
- regional traffic by road type
- local authority traffic by vehicle class

Raw data was stored locally in:

```text
data/raw/
```

Raw files were not uploaded to GitHub because they are external source files and may be large.

---

## 3. Data Understanding

The first notebook inspected the raw downloaded files.

Notebook used:

```text
notebooks/01_data_understanding.ipynb
```

This stage reviewed:

- raw file names
- file extensions
- file sizes
- CSV structures
- ODS workbook sheet names
- first rows of raw files
- candidate datasets for analysis

---

## 4. Data Cleaning and Preparation

The second notebook cleaned and prepared the data.

Notebook used:

```text
notebooks/02_data_cleaning.ipynb
```

Cleaning steps included:

- loading raw CSV and ODS files
- removing empty rows and columns
- standardising column names into snake_case
- extracting readable ODS sheets
- exporting cleaned local CSV files
- creating raw and processed file inventories

Cleaned files were saved locally in:

```text
data/processed/
```

Processed CSV files were not uploaded to GitHub.

---

## 5. Exploratory Data Analysis

The third notebook reviewed the cleaned outputs and identified useful analysis tables.

Notebook used:

```text
notebooks/03_exploratory_data_analysis.ipynb
```

This stage included:

- profiling all processed datasets
- identifying useful year, region, road type and vehicle type columns
- creating numeric summaries
- scoring candidate dashboard datasets
- exporting EDA metadata outputs
- selecting the strongest datasets for SQL and Power BI

---

## 6. SQLite Database Creation

A local SQLite database was created using:

```text
src/create_sqlite_database.py
```

Database created locally:

```text
data/processed/uk_logistics_road_freight.db
```

The script loaded processed CSV files into SQLite tables and created a database catalog table.

The database was not uploaded to GitHub because it is generated locally.

---

## 7. SQL Analysis

SQL files were created for:

- data quality checks
- logistics analysis queries
- Power BI reporting views

SQL files:

```text
sql/01_data_quality_checks.sql
sql/02_logistics_analysis_queries.sql
sql/03_views_for_powerbi.sql
```

The SQL layer focused on regional road traffic, vehicle type traffic, road network length and logistics pressure proxy metrics.

---

## 8. SQL Views for Power BI

SQL views were created using:

```text
src/run_sql_views.py
```

The views prepared clean reporting datasets for Power BI, including:

- regional logistics KPI summary
- HGV trend by region
- road category summary
- regional road network summary
- logistics pressure proxy
- latest-year dashboard views

---

## 9. Power BI Export Layer

SQL views were exported into local CSV files using:

```text
src/export_powerbi_views.py
```

Exported files were saved locally in:

```text
data/processed/powerbi_views/
```

These files were used as the source data for the Power BI dashboard.

---

## 10. Power BI Dashboard

The Power BI dashboard was created in:

```text
powerbi/dashboard.pbix
```

The dashboard contains three pages:

1. Executive Summary
2. Regional Logistics Analysis
3. Road Network & Traffic Pressure

Dashboard screenshots were exported into:

```text
powerbi/dashboard_screenshots/
```

---

## 11. Documentation and GitHub

The project includes:

- README documentation
- data source notes
- SQL database notes
- notebooks
- SQL scripts
- Python scripts
- Power BI dashboard
- dashboard screenshots
- business reports

The final GitHub repository is designed to be clear and reviewable by recruiters, hiring managers and technical reviewers.
