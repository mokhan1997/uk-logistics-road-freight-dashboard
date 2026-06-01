# Executive Summary

## Project Title

UK Logistics & Road Freight Intelligence Dashboard

## Project Purpose

This project analyses official Department for Transport road traffic and road freight-related datasets to understand UK regional logistics activity, HGV movement, LGV movement, road network length and traffic pressure patterns.

The project was built as an end-to-end data analytics portfolio project using Python, SQL, SQLite, Power BI and GitHub documentation.

The purpose of the project is to show how public transport datasets can be converted into useful business intelligence for logistics, transport, fleet and operations decision-making.

---

## Business Context

Road freight and road transport are critical parts of the UK supply chain.

Logistics operators, transport planners and operations leaders need visibility of:

- HGV activity
- LGV activity
- regional traffic demand
- road network coverage
- road category distribution
- traffic pressure by region
- long-term traffic trends

This type of analysis can support transport planning, network capacity review, regional demand understanding and operational decision-making.

---

## Business Problem

The main business question explored in this project is:

Can official UK road traffic and freight-related datasets be used to create a regional logistics intelligence dashboard that helps identify transport demand, HGV/LGV activity and road network pressure?

The project focuses on turning raw public data into clean, dashboard-ready insight.

---

## Dashboard Pages

The Power BI dashboard contains three pages:

| Page                            | Purpose                                                                                                               |
| ------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| Executive Summary               | High-level overview of regional HGV activity, LGV activity, motor traffic, road network length and logistics pressure |
| Regional Logistics Analysis     | Regional comparison of HGV traffic, LGV traffic, motor vehicle traffic, traffic per kilometre and long-term trends    |
| Road Network & Traffic Pressure | Analysis of road network length, road category distribution and traffic pressure by region                            |

---

## Key Analysis Areas

The project analyses:

- HGV traffic by region
- LGV traffic by region
- total motor vehicle traffic
- HGV share of motor traffic
- LGV share of motor traffic
- HGV traffic per kilometre
- LGV traffic per kilometre
- road network length by region
- road network length by road category
- long-term HGV and LGV traffic trends

---

## Business Value

This project demonstrates how transport data can support practical logistics and operations decisions.

The dashboard could help a transport or logistics team:

- identify regions with higher HGV activity
- compare regional LGV demand
- understand road network coverage
- monitor regional transport pressure
- support network planning conversations
- highlight areas with higher traffic intensity
- create an evidence base for transport and logistics decisions

---

## Limitations

This project has the following limitations:

- The analysis depends on the downloaded Department for Transport datasets.
- Some road freight ODS tables were less suitable for immediate dashboard use due to table formatting complexity.
- The Power BI dashboard is currently focused mainly on regional road traffic datasets.
- The project uses traffic and road network metrics as a logistics pressure proxy.
- It does not include company-level freight volumes, delivery performance, cost data or vehicle utilisation data.
- Public datasets may have different update cycles and levels of detail.

---

## Future Improvements

Future improvements could include:

- adding cleaned road freight ODS tables into the SQL and Power BI layer
- adding domestic freight goods lifted and goods moved statistics
- adding freight origin/destination flows
- adding HGV empty running and loading factor analysis
- creating a logistics pressure score by region
- adding map visuals in Power BI
- comparing road freight activity with population, warehouse location or port data
- building a predictive model for regional traffic pressure
