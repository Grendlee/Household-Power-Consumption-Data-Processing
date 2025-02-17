# Household-Power-Consumption-Data-Processing

## Overview  
This project analyzes household energy consumption data by handling missing values, detecting anomalies, and computing correlation matrices for key features. It utilizes **R programming** with **linear interpolation**, **Z-score anomaly detection**, and **Pearson correlation analysis** to extract meaningful insights from time-series data.

## Features  
✅ **Data Cleaning:** Uses **linear interpolation** to fill missing values in the dataset.  
✅ **Anomaly Detection:** Identifies outliers using **Z-score thresholding** (|Z| > 3).  
✅ **Correlation Analysis:** Computes and visualizes **Pearson correlation coefficients** between energy usage parameters.  
✅ **Time-Series Extraction:** Filters data for the **16th week of 2007** based on group assignment.  
✅ **Visualization:** Displays the correlation matrix using **color-coded heatmaps**.

## Technologies Used  
- **R** (Data processing, statistical analysis)  
- **zoo** (Handling missing values)  
- **corrplot** (Visualizing correlation matrices)  
- **POSIXlt** (Date-time conversion for time-series filtering)

## Dataset  
The dataset used in this project is stored in `Dataset.txt`. It contains power consumption readings recorded over time.

## Installation & Setup  
1. Install required R libraries:  
   ```r
   install.packages("zoo")
   install.packages("corrplot")
