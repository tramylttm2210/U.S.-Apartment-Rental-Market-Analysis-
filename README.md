# U.S. Apartment Rental Market Analysis

## Purpose  
To analyze 10,000 U.S. apartment listings, uncover pricing patterns, evaluate the influence of apartment features on rent, and identify geographic trends—providing insights for renters, landlords, and policymakers to understand the dynamics of the rental housing market.

## Tools & Packages  
**Data Cleaning:** `readr`, `janitor`, `dplyr`, `stringr`  
**Visualization:** `ggplot2`  
**Analysis:** histogram, boxplot, bar chart, descriptive statistics, trend extrapolation  

## Project Overview  
Preprocessed 10,000 apartment listings from the UCI Machine Learning Repository. Data preparation included:
- Character encoding correction (ISO-8859-1)
- Removal of irrelevant or invalid records (e.g., listings with "Contact for price")
- Numeric conversion of price and room counts
- Standardization of state and city fields
- Filtering out categorical placeholder values like `"null"`

These steps ensured analytical reliability and clean, structured data for exploration.

## Exploratory Data Analysis  

### Rental Price Distribution  
- **Most listings** fall between **$800–$1,500/month**  
- **Right-skewed** distribution with a long tail of high-end listings above **$3,000**  
- **Peak around $1,000** indicating a common pricing threshold  

### Bedroom Count Analysis  
- **1-bedroom units** dominate the market  
- Studios (0-bedroom) are rare; 5+ bedroom listings are outliers for luxury markets  
- **Bar charts** and **boxplots** show a **non-linear price increase** as bedroom count rises  

### Geographic Trends  
- **Top 5 states by average rent:**  
  1. Hawaii  
  2. California  
  3. Massachusetts  
  4. Washington D.C.  
  5. Washington State  
- High rents are **coastal and urban concentrated**

## Descriptive Statistics  

| Feature        | Mean   | Median | Max     | Notes                                      |
|----------------|--------|--------|---------|--------------------------------------------|
| Price (USD)    | —      | ~1,100 | >3,000  | Right-skewed with luxury price outliers    |
| Square Footage | 845.3  | 719    | 5,700   | Median reflects compact urban housing      |
| Bedrooms       | 1.64   | 1      | 9       | One-bedroom units most common              |
| Bathrooms      | 1.23   | 1      | 5       | Most listings have a single bathroom       |

## Forecasting & Predictive Insights  

### Rental Price Trajectory  
- Urban and coastal areas will likely experience **continued price growth**  
- Inland states may remain more affordable unless demand shifts significantly  

### Bedroom Trends  
- **1–2 bedroom units** expected to remain dominant  
- **Luxury units (5+ bedrooms)** likely to stay niche but high-value  

### Regional Gaps  
- The **coastal-inland affordability divide** is projected to persist or widen  
- Supply-side housing policies will play a key role in shifting this trend  

## Actionable Insight  
- **Renters** in high-cost states should budget for increasing prices  
- **Landlords** may focus on 1–2 bedroom units for consistent demand  
- **Policymakers** can use geographic insights to guide affordable housing development  

## Future Exploration  
- Analyze **price per square foot** across regions for efficiency  
- Evaluate how **specific amenities** (e.g., pool, gym, parking) affect rent  
- Conduct **time-series analysis** by converting timestamps to dates for market trend forecasting  

## Data Source  
Dataset: [UCI Machine Learning Repository – Apartment for Rent Classifieds Dataset (RentLingo)](https://archive.ics.uci.edu/dataset/555/apartment+for+rent+classified)
