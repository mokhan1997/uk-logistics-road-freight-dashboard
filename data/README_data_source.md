# Data Source

## Project Title

UK Logistics & Road Freight Intelligence Dashboard

## Data Sources

This project uses official UK Department for Transport data.

The project combines:

1. Road freight statistics tables
2. Road traffic statistics downloads

The data is used to analyse UK road freight movement, HGV activity, regional traffic patterns and logistics network demand.

---

## Road Freight Statistics

The road freight data was downloaded from the GOV.UK domestic road freight statistics tables.

The downloaded tables include:

- RFS0101 — Goods moved, goods lifted and vehicle kilometres
- RFS0121 — Goods lifted and goods moved by region and country of origin
- RFS0122 — Goods lifted and goods moved by region/country of origin and destination
- RFS0125 — Percentage empty running and loading factor by vehicle type and weight

These tables help analyse:

- Goods lifted
- Goods moved
- Vehicle kilometres
- Regional freight flows
- Empty running
- Loading factor
- HGV utilisation

---

## Road Traffic Statistics

The road traffic data was downloaded from the Department for Transport road traffic statistics downloads.

The downloaded files include:

- Regional traffic by vehicle type
- Regional traffic by road type
- Local authority traffic by vehicle class

These datasets help analyse:

- Road traffic by region
- HGV and vehicle activity
- Road type demand
- Local authority traffic patterns
- Regional transport pressure

---

## Raw Data Storage

Raw downloaded data files are stored locally in:

```text
data/raw/
```
