-- ============================================================
-- Project: UK Logistics & Road Freight Intelligence Dashboard
-- File: 03_views_for_powerbi.sql
-- Purpose: SQL views for Power BI reporting
-- ============================================================


-- 1. Regional road type reporting view
DROP VIEW IF EXISTS v_region_road_type_dashboard;

CREATE VIEW v_region_road_type_dashboard AS
SELECT
    year,
    region_id,
    region_name,
    region_ons_code,
    road_category_id,
    road_category_name,
    link_length_km,
    link_length_miles
FROM cleaned_region_traffic_by_road_type;


-- 2. Regional vehicle type reporting view
DROP VIEW IF EXISTS v_region_vehicle_type_dashboard;

CREATE VIEW v_region_vehicle_type_dashboard AS
SELECT
    year,
    region_id,
    region_name,
    region_ons_code,
    link_length_km,
    link_length_miles,
    pedal_cycles,
    two_wheeled_motor_vehicles,
    cars_and_taxis,
    buses_and_coaches,
    lgvs,
    all_hgvs,
    all_motor_vehicles
FROM cleaned_region_traffic_by_vehicle_type;


-- 3. Latest year vehicle traffic view
DROP VIEW IF EXISTS v_latest_year_vehicle_traffic;

CREATE VIEW v_latest_year_vehicle_traffic AS
SELECT
    *
FROM v_region_vehicle_type_dashboard
WHERE year = (
    SELECT MAX(year)
    FROM v_region_vehicle_type_dashboard
);


-- 4. Latest year road type view
DROP VIEW IF EXISTS v_latest_year_road_type;

CREATE VIEW v_latest_year_road_type AS
SELECT
    *
FROM v_region_road_type_dashboard
WHERE year = (
    SELECT MAX(year)
    FROM v_region_road_type_dashboard
);


-- 5. Regional logistics KPI summary
DROP VIEW IF EXISTS v_regional_logistics_kpi;

CREATE VIEW v_regional_logistics_kpi AS
SELECT
    year,
    region_name,
    ROUND(SUM(link_length_km), 2) AS total_link_length_km,
    ROUND(SUM(link_length_miles), 2) AS total_link_length_miles,
    ROUND(SUM(lgvs), 2) AS total_lgvs,
    ROUND(SUM(all_hgvs), 2) AS total_hgv_traffic,
    ROUND(SUM(all_motor_vehicles), 2) AS total_motor_vehicle_traffic,
    ROUND(
        100.0 * SUM(all_hgvs) / NULLIF(SUM(all_motor_vehicles), 0),
        2
    ) AS hgv_share_of_motor_traffic_percent,
    ROUND(
        100.0 * SUM(lgvs) / NULLIF(SUM(all_motor_vehicles), 0),
        2
    ) AS lgv_share_of_motor_traffic_percent
FROM cleaned_region_traffic_by_vehicle_type
GROUP BY
    year,
    region_name;


-- 6. Latest year regional logistics KPI summary
DROP VIEW IF EXISTS v_latest_regional_logistics_kpi;

CREATE VIEW v_latest_regional_logistics_kpi AS
SELECT
    *
FROM v_regional_logistics_kpi
WHERE year = (
    SELECT MAX(year)
    FROM v_regional_logistics_kpi
);


-- 7. Road category summary
DROP VIEW IF EXISTS v_road_category_summary;

CREATE VIEW v_road_category_summary AS
SELECT
    year,
    road_category_name,
    ROUND(SUM(link_length_km), 2) AS total_link_length_km,
    ROUND(SUM(link_length_miles), 2) AS total_link_length_miles
FROM cleaned_region_traffic_by_road_type
GROUP BY
    year,
    road_category_name;


-- 8. Latest year road category summary
DROP VIEW IF EXISTS v_latest_road_category_summary;

CREATE VIEW v_latest_road_category_summary AS
SELECT
    *
FROM v_road_category_summary
WHERE year = (
    SELECT MAX(year)
    FROM v_road_category_summary
);


-- 9. Regional road network summary
DROP VIEW IF EXISTS v_regional_road_network_summary;

CREATE VIEW v_regional_road_network_summary AS
SELECT
    year,
    region_name,
    ROUND(SUM(link_length_km), 2) AS total_link_length_km,
    ROUND(SUM(link_length_miles), 2) AS total_link_length_miles
FROM cleaned_region_traffic_by_road_type
GROUP BY
    year,
    region_name;


-- 10. Latest year regional road network summary
DROP VIEW IF EXISTS v_latest_regional_road_network_summary;

CREATE VIEW v_latest_regional_road_network_summary AS
SELECT
    *
FROM v_regional_road_network_summary
WHERE year = (
    SELECT MAX(year)
    FROM v_regional_road_network_summary
);


-- 11. HGV trend by region
DROP VIEW IF EXISTS v_hgv_trend_by_region;

CREATE VIEW v_hgv_trend_by_region AS
SELECT
    year,
    region_name,
    ROUND(SUM(all_hgvs), 2) AS total_hgv_traffic,
    ROUND(SUM(lgvs), 2) AS total_lgvs,
    ROUND(SUM(all_motor_vehicles), 2) AS total_motor_vehicle_traffic
FROM cleaned_region_traffic_by_vehicle_type
GROUP BY
    year,
    region_name;


-- 12. Logistics pressure proxy
DROP VIEW IF EXISTS v_logistics_pressure_proxy;

CREATE VIEW v_logistics_pressure_proxy AS
SELECT
    year,
    region_name,
    ROUND(SUM(all_hgvs), 2) AS total_hgv_traffic,
    ROUND(SUM(lgvs), 2) AS total_lgvs,
    ROUND(SUM(all_motor_vehicles), 2) AS total_motor_vehicle_traffic,
    ROUND(SUM(link_length_km), 2) AS total_link_length_km,
    ROUND(
        SUM(all_hgvs) / NULLIF(SUM(link_length_km), 0),
        2
    ) AS hgv_traffic_per_km,
    ROUND(
        SUM(lgvs) / NULLIF(SUM(link_length_km), 0),
        2
    ) AS lgv_traffic_per_km
FROM cleaned_region_traffic_by_vehicle_type
GROUP BY
    year,
    region_name;


-- 13. Latest logistics pressure proxy
DROP VIEW IF EXISTS v_latest_logistics_pressure_proxy;

CREATE VIEW v_latest_logistics_pressure_proxy AS
SELECT
    *
FROM v_logistics_pressure_proxy
WHERE year = (
    SELECT MAX(year)
    FROM v_logistics_pressure_proxy
);