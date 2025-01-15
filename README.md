# **IMDB Movie Analysis**

## **Overview**
This repository contains an analysis of the IMDB dataset, exploring factors that influence the box office success of movies and TV shows. The dataset, sourced from Kaggle, includes key variables such as IMDB ratings, gross revenue, runtime, and more. The project aims to uncover insights through data cleaning, association analysis, and regression modeling. Detailed results and conclusions are documented in [Finalreport.pdf](https://github.com/giocondaprada91/IMDB_Movie_Analysis/blob/ac31ac1ab0bd41320dca0d22ee8d8390a7bc1c64/Finalreport.pdf)

---

## **Dataset**
- **Source**: The dataset was obtained from [Kaggle](https://www.kaggle.com/).
- **Key Features**:
  - IMDB Ratings
  - Gross Revenue
  - Runtime (converted to decimal hours)
  - Meta Scores
  - Number of Votes
  - Release Year

---

## **Project Structure**
- **`scripts/`**: Contains R code for data processing and analysis.
  - `data_cleaning.R`: Prepares the dataset for analysis.
  - `analysis.R`: Conducts association and regression analyses.
  - `visualizations.R`: Generates plots and visualizations.
- **`data/`**: Includes the raw dataset (if sharing is allowed) or instructions to access it.
- **`docs/`**: Contains the final report summarizing key findings.
- **`README.md`**: Overview of the project and usage instructions.

---

## **Results**
All results, insights, and conclusions are documented in the [Final Report](./docs/final_report.pdf). Highlights include:
- Statistical relationships between variables like IMDB ratings, runtime, and gross revenue.
- Insights into factors influencing movie success.
- Limitations of the dataset in fully predicting box office performance.

---

## **How We Ran the Code**

### **1. Prerequisites**
- **R Installed**: Install R from [CRAN](https://cran.r-project.org/).
- **Required Libraries**: Install the necessary libraries using the command:
  ```R
  install.packages(c("readr", "dplyr", "magrittr", "vcd", "rcompanion", "corrplot", "ggplot2", "regclass"))
  ```

### **2. Steps to Run the Code**
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/IMDB_Movie_Analysis.git
   ```
2. **Navigate to the Code Folder**:
   Open the `scripts/` folder and locate the relevant R script (`analysis.R` or similar).
3. **Run in RStudio**:
   Open the script in RStudio or any R IDE. Run each section of the code sequentially to replicate the analysis.

### **3. Notes**
- **Dataset Location**: Update the file path in the `read.csv()` function to match the location of the dataset on your local machine.
- **Saved Outputs**: The cleaned dataset is saved as `cleaned_data_set.csv` in your working directory.

---

## **Acknowledgments**
- The dataset used in this project was sourced from [Kaggle](https://www.kaggle.com/).
- Special thanks to all contributors and resources that supported this analysis.

---

If you encounter any issues or have questions, feel free to open an issue in this repository.
