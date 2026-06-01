-- ============================================================
-- Project: UK Logistics & Road Freight Intelligence Dashboard
-- File: 01_data_quality_checks.sql
-- Purpose: Data quality checks for logistics and road traffic database
-- ============================================================


-- 1. Check database table catalog
SELECT
    table_name,
    source_file,
    rows,
    columns,
    file_size_mb
FROM database_table_catalog
ORDER BY rows DESC;


-- 2. Row count: regional traffic by road type
SELECT
    COUNT(*) AS total_rows
FROM cleaned_region_traffic_by_road_type;


-- 3. Row count: regional traffic by vehicle type
SELECT
    COUNT(*) AS total_rows
FROM cleaned_region_traffic_by_vehicle_type;


-- 4. Year coverage: road type table
SELECT
    MIN(year) AS min_year,
    MAX(year) AS max_year,
    COUNT(DISTINCT year) AS year_count
FROM cleaned_region_traffic_by_road_type;


-- 5. Year coverage: vehicle type table
SELECT
    MIN(year) AS min_year,
    MAX(year) AS max_year,
    COUNT(DISTINCT year) AS year_count
FROM cleaned_region_traffic_by_vehicle_type;


-- 6. Region coverage: road type table
SELECT
    COUNT(DISTINCT region_name) AS unique_regions
FROM cleaned_region_traffic_by_road_type;


-- 7. Region coverage: vehicle type table
SELECT
    COUNT(DISTINCT region_name) AS unique_regions
FROM cleaned_region_traffic_by_vehicle_type;


-- 8. Road category coverage
SELECT
    road_category_name,
    COUNT(*) AS record_count
FROM cleaned_region_traffic_by_road_type
GROUP BY road_category_name
ORDER BY record_count DESC;


-- 9. Missing values check: road type table
SELECT
    SUM(CASE WHEN year IS NULL THEN 1 ELSE 0 END) AS missing_year,
    SUM(CASE WHEN region_name IS NULL THEN 1 ELSE 0 END) AS missing_region_name,
    SUM(CASE WHEN road_category_name IS NULL THEN 1 ELSE 0 END) AS missing_road_category_name,
    SUM(CASE WHEN link_length_km IS NULL THEN 1 ELSE 0 END) AS missing_link_length_km,
    SUM(CASE WHEN link_length_miles IS NULL THEN 1 ELSE 0 END) AS missing_link_length_miles
FROM cleaned_region_traffic_by_road_type;


-- 10. Missing values check: vehicle type table
SELECT
    SUM(CASE WHEN year IS NULL THEN 1 ELSE 0 END) AS missing_year,
    SUM(CASE WHEN region_name IS NULL THEN 1 ELSE 0 END) AS missing_region_name,
    SUM(CASE WHEN link_length_km IS NULL THEN 1 ELSE 0 END) AS missing_link_length_km,
    SUM(CASE WHEN link_length_miles IS NULL THEN 1 ELSE 0 END) AS missing_link_length_miles
FROM cleaned_region_traffic_by_vehicle_type;