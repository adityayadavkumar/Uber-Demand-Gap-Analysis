# Uber-Demand-Gap-Analysis
An end-to-end data analytics project investigating Uber ride request outcomes, driver cancellations, and car availability using Excel, MySQL, Python, Pandas, and data visualization.
# Uber Supply–Demand Gap Analysis

## Project Overview

The **Uber Supply–Demand Gap Analysis** project focuses on understanding the gap between customer ride requests and the availability of drivers. The main objective is to analyze Uber ride request data, identify the major reasons for unsuccessful trips, and discover patterns related to ride cancellations and the unavailability of cars.

This project uses Exploratory Data Analysis (EDA), data cleaning, SQL queries, and Excel dashboards to transform raw ride request data into meaningful insights. By examining ride outcomes across different pickup locations and time periods, the project aims to identify areas where driver availability and service efficiency can be improved.

## Problem Statement

In a ride-booking service, customer requests do not always result in completed trips. Some requests are cancelled by drivers, while others cannot be fulfilled because no cars are available. These issues can affect customer satisfaction and the overall efficiency of the service.

The purpose of this project is to investigate these unsuccessful requests, understand how they vary by pickup point and time of day, and recommend possible strategies for improving ride fulfilment.

## Dataset Description

The dataset contains **6,745 ride requests** with six original columns:

- **Request ID:** Unique identifier for each ride request.
- **Pickup Point:** Indicates whether the pickup location is the City or Airport.
- **Driver ID:** Identifier of the driver assigned to a request.
- **Status:** Describes the outcome of the request.
- **Request Timestamp:** Records when the customer made the request.
- **Drop Timestamp:** Records the trip completion time when available.

The request status includes three categories: Trip Completed, Cancelled, and No Cars Available.

## Tools and Technologies

The following tools and technologies are used in this project:

- **Microsoft Excel:** Data preparation, summary tables, and dashboard creation.
- **MySQL:** Database management and SQL-based analysis.
- **Python:** Exploratory data analysis and data processing.
- **Pandas and NumPy:** Data manipulation and numerical analysis.
- **Matplotlib and Seaborn:** Data visualization.
- **Jupyter Notebook:** Executing and documenting the EDA workflow.

## Project Workflow

1. Load and inspect the original dataset.
2. Identify missing values and duplicate records.
3. Clean the data and prepare timestamp-related features.
4. Analyze request outcomes using SQL queries.
5. Explore patterns by pickup point, hour, and time slot.
6. Create Excel charts and dashboards.
7. Develop Python visualizations to understand trends and relationships.
8. Summarize findings and propose business recommendations.

## Key Findings

The dataset contains 2,831 completed trips, 1,264 cancelled requests, and 2,650 requests with no cars available. These results indicate that a significant proportion of ride requests did not become completed trips.

The analysis focuses on identifying periods and locations associated with unsuccessful requests. The findings can help guide further investigation into driver availability, cancellation patterns, and demand management.

## Business Benefits

This project demonstrates how data analytics can support operational decision-making. The findings may help identify periods requiring better driver coverage, support the evaluation of targeted driver incentives, and improve monitoring of ride completion and cancellation rates.

## Conclusion

The Uber Supply–Demand Gap Analysis project demonstrates an end-to-end data analytics workflow using Excel, SQL, and Python. It combines data preparation, database queries, exploratory visualization, and business interpretation to investigate ride fulfilment challenges. The project also highlights the importance of using data-driven insights to develop and evaluate strategies for improving service reliability and customer experience.
