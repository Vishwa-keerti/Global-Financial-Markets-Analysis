# Global Financial Markets Analysis

## Project Overview

This project analyzes historical financial market data using **Python, PostgreSQL, SQL, and Power BI** to explore market performance, daily returns, and volatility across global financial markets.

The project combines data from stock market indices and commodities to identify performance patterns and compare market behavior over time.

**Project Status:** In Progress

## Objectives

- Analyze historical price movements across different financial markets.
- Calculate percentage price changes and daily returns using SQL.
- Compare market volatility to understand differences in price fluctuations.
- Identify major market declines using maximum drawdown analysis.
- Build an interactive Power BI dashboard to communicate key findings.

## Markets Covered

The analysis currently includes five datasets:

| Market | Category |
|---|---|
| NIFTY 50 | Indian stock market index |
| S&P 500 | US stock market index |
| Nikkei 225 | Japanese stock market index |
| Gold Futures | Commodity futures |
| Brent Oil Futures | Commodity futures |

**Data period:** January 2015 – March 2026, based on the cleaned dataset.

## Tools & Technologies

- **Python (Pandas):** Data cleaning, transformation, and consolidation.
- **PostgreSQL:** Data storage and querying.
- **SQL:** Window functions, CTEs, aggregate functions, views, and financial performance analysis.
- **Power BI:** Planned interactive dashboard and data visualization.

## Dataset

The historical market data was obtained from the following GitHub repository:

[Stock Market Dataset – Hareeshkesavan](https://github.com/Hareeshkesavan/Stock-Market-Dataset)

The datasets include historical prices and related fields such as opening price, highest price, lowest price, and percentage change.

## Data Cleaning and Preparation

Python and Pandas were used to prepare the raw CSV files for analysis.

Key steps included:

- Standardizing column names and data formats.
- Converting dates into a consistent format.
- Converting price and percentage fields into numeric values.
- Combining the five datasets into a single structured dataset.
- Removing records with invalid required values.
- Checking for duplicate market-date records.
- Exporting the consolidated data for PostgreSQL.

The cleaned dataset contains **13,773 records** across the five markets, with no duplicate market-date records detected during validation.

## SQL Analysis

PostgreSQL is used to store the cleaned data and perform analytical queries.

### 1. Overall Price Performance

Calculated the percentage change between the first and last recorded prices for each market over its available data period.

This provides a simple comparison of historical price appreciation, rather than annualized investment returns.

### 2. Daily Returns

Created a reusable SQL view named `market_returns` using the `LAG()` window function.

The view calculates the percentage change between consecutive recorded prices for each market.

```sql
(price - previous_price) / previous_price * 100
```

This makes it possible to analyze daily price movements without repeatedly writing the same calculation.

### 3. Monthly Performance Analysis

Aggregated daily returns by market and month to examine average daily returns and identify the best and worst recorded daily returns within each month.

### 4. Volatility Analysis

Calculated sample standard deviation of daily returns and estimated annualized volatility using the conventional square-root-of-time scaling factor.

The initial analysis indicated that Brent Oil was the most volatile of the five markets, followed by Nikkei 225, while NIFTY 50 was the least volatile in the analyzed dataset.

### 5. Maximum Drawdown Analysis

Planned analysis to measure the largest percentage decline from a previous recorded price peak to a subsequent trough.

## Initial Findings

- Gold Futures recorded the largest overall price increase across the respective available sample periods in the initial analysis.
- Brent Oil Futures recorded the highest estimated volatility among the five markets.
- NIFTY 50 recorded the lowest estimated volatility among the five markets.
- Overall price appreciation and volatility measure different aspects of market behavior and should not be interpreted interchangeably.

These findings are descriptive and depend on the selected dataset, observation period, and calculation methodology.

## Project Structure

```text
Global_Market_Analysis/
│
├── data/
│   ├── Nifty 50 Historical Data.csv
│   ├── S&P 500 Historical Data.csv
│   ├── Nikkei 225 Historical Data.csv
│   ├── Gold Futures Historical Data.csv
│   ├── Brent Oil Futures Historical Data.csv
│   └── market_data_clean.csv
│
├── clean_data.py
├── README.md
└── sql/
    └── market_analysis.sql
```

*Note: The SQL directory and consolidated SQL script can be added as the analysis queries are organized.*

## Future Improvements

- Complete maximum drawdown analysis.
- Analyze annual performance and extreme daily price movements.
- Examine relationships between market returns.
- Develop an interactive Power BI dashboard.
- Document additional insights and analytical limitations.

## Key Learnings

- Cleaning and consolidating data from multiple CSV sources using Pandas.
- Designing a structured PostgreSQL table with data integrity constraints.
- Applying SQL window functions such as `LAG()` and running aggregates.
- Creating reusable views and CTE-based analytical queries.
- Interpreting historical performance, returns, and volatility.

---

**Disclaimer:** This project is for educational and analytical purposes only. Historical market data and calculated metrics do not guarantee future performance or constitute investment advice.

