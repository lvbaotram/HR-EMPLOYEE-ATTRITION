# INTRODUCTION
Employee attrition is a significant challenge for organizations as it directly impacts operational efficiency, workforce stability, and overall costs. Understanding the factors contributing to employee turnover is crucial for devising effective retention strategies. This project aims to analyze the attrition patterns within a company's workforce using the EmployeeAttrition dataset, which includes information on 1,470 employees across various departments, roles, and demographics. Through this analysis, we aim to uncover key insights into attrition rates and identify underlying factors driving employee turnover.
Employee attrition, or turnover, is a critical issue that affects organizations across various industries. High attrition rates can lead to increased recruitment costs, loss of organizational knowledge, and decreased overall productivity. As a result, it is essential for companies to understand the factors contributing to employee attrition to develop effective strategies for retaining talent.

This project involves analyzing employee attrition data using SQL to uncover patterns and insights that can help an organization better understand why employees leave. By examining key factors such as gender, salary, job satisfaction, travel requirements, and department, the analysis aims to identify the major drivers of attrition and suggest actionable recommendations for improving employee retention.
# PROBLEM
The key questions analyzed include:

* Determining the overall attrition rate in the company.
* Comparing attrition rates by gender and income levels.
* Analyzing job satisfaction, work environment, and employee involvement.
* Evaluating the impact of frequent travel on employee attrition.
* Analyzing attrition by department and education level.
# ABOUT DATASET
I sourced the dataset from Kaggle as a CSV file and includes 1471 entries with 35 columns. The dataset comprises the following columns:

Age, Attrition, BusinessTravel, DailyRate, Department, DistanceFromHome, Education, EducationField, EmployeeCount, EmployeeNumber, EnvironmentSatisfaction, Gender, HourlyRate, JobInvolvement, JobLevel, JobRole, JobSatisfaction, MaritalStatus, MonthlyIncome, MonthlyRate, NumCompaniesWorked, Over18, OverTime, PercentSalaryHike, PerformanceRating, RelationshipSatisfaction, StandardHours, StockOptionLevel, TotalWorkingYears, TrainingTimesLastYear, WorkLifeBalance, YearsAtCompany, YearsInCurrentRole, YearsSinceLastPromotion, YearsWithCurrManager.
# Data Cleaning
Using Excel to adjust row height and column width, checked for duplicates and blank cells (none found).
# CONCLUSION AND RECOMMENDATION
## Conclusion
* Attrition Rate: The overall attrition rate is 16.12%. Among genders, males have an attrition rate of 17%, while females have a rate of 15%.
* Wages and Gender: The average wages for employees who leave are nearly identical between males and females, indicating the company maintains fair compensation across genders.
* Travel: Employees who travel frequently have the highest attrition rate (25%), compared to those who travel rarely (15%) and non-traveling employees (8%).
* Departments: Sales has the highest attrition rate (21%), followed by HR (19%) and R&D (14%).
* Age: Employees aged 18-39 have the highest attrition rate, particularly those in higher job levels tend to have lower attrition rates.
* Work Environment and Engagement: Employees with lower job satisfaction and engagement levels are 3-4 times more likely to leave, especially those earning below average salaries
## Recommendation
* Enhance Compensation Policies: Consider increasing salaries for employees in departments with high attrition rates, such as HR and Sales, particularly for those earning below the average.
* Improve Work Environment: Boost employee satisfaction and engagement through team-building activities, skill development training, and creating clear career advancement opportunities.
* Review Travel Policies: Provide additional support for employees who travel frequently, such as travel allowances, flexible leave policies, or remote work options when possible.
