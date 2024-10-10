
--Number of Employees = 1470
SELECT Count(*) as 'Total Employees'
FROM EmployeeAttrition

--Number of Employees where Attrition is YES = 237

SELECT COUNT(*)	as 'AttritionYES'
FROM EmployeeAttrition
WHERE Attrition = 'Yes'

--Percentage of employees where Attrition is 'Yes' = 16.12%

SELECT concat(round((CAST(count(*) as FLOAT)/
			 (SELECT CAST(count(*) as FLOAT)FROM EmployeeAttrition))*100,2),'%') AS 'Attrition Rate'
FROM EmployeeAttrition
WHERE Attrition = 'Yes'


---GENDER
--Total Employees by Gender

SELECT Gender, COUNT(*) as 'Total Employees by Gender', (SELECT COUNT(*)
							FROM dbo.EmployeeAttrition b
						        WHERE b.Gender = a.Gender AND Attrition = 'Yes' 
						        ) AS 'Attrition by Gender'
FROM dbo.EmployeeAttrition a
GROUP BY Gender

--Attrition Rate by Gender

SELECT Gender, COUNT(*) 'Attrition by Gender', concat(round((CAST(count(*) as FLOAT)/
			 (SELECT COUNT(*) FROM dbo.EmployeeAttrition WHERE Gender = 'Male'))*100,2),'%') AS 'Attrition Rate'
FROM EmployeeAttrition
WHERE Attrition = 'Yes' and Gender = 'Male'
GROUP BY Gender

SELECT Gender, COUNT(*) 'Attrition by Gender', concat(round((CAST(count(*) as FLOAT)/
			 (SELECT COUNT(*) FROM dbo.EmployeeAttrition WHERE Gender = 'Female'))*100,2),'%') AS 'Attrition Rate'
FROM EmployeeAttrition
WHERE Attrition = 'Yes' and Gender = 'Female'
GROUP BY Gender
--We can see that Attrition between Genders is nearly identical with around 17% of Total Males and around 15% of Total Females

SELECT DISTINCT Gender, EnvironmentSatisfaction, COUNT(*) 'Attrition by Gender'
FROM dbo.EmployeeAttrition
WHERE Attrition = 'Yes' 
GROUP BY Gender, EnvironmentSatisfaction

---WAGES
--Total wages of Attrition employees
SELECT SUM(HourlyRate) as 'Hourly Rate', SUM(DAILYRATE) as 'Daily Rate', SUM(MonthlyIncome) as 'Monthly Income', SUM(MonthlyRate) as 'Monthly Rate'
FROM dbo.EmployeeAttrition
WHERE Attrition = 'Yes' 

--Average wages of all employees
SELECT ROUND(AVG(HourlyRate),0) as 'Average Hourly Rate', ROUND(AVG(DailyRate),0) as 'Average Daily Rate', ROUND(AVG(MonthlyIncome),0) as 'Average Monthly Income', ROUND(AVG(MonthlyRate),0) as 'Average Monthly Rate'
FROM dbo.EmployeeAttrition

SELECT ROUND(AVG(HourlyRate),0) as 'Average Hourly Rate', ROUND(AVG(DailyRate),0) as 'Average Daily Rate', ROUND(AVG(MonthlyIncome),0) as 'Average Monthly Income', ROUND(AVG(MonthlyRate),0) as 'Average Monthly Rate'
FROM dbo.EmployeeAttrition
WHERE Attrition = 'Yes'

--Average wages of Attrition employees by Gender

SELECT ROUND(AVG(HourlyRate),0) as 'Average Hourly Rate', ROUND(AVG(DailyRate),0) as 'Average Daily Rate', ROUND(AVG(MonthlyIncome),0) as 'Average Monthly Income', ROUND(AVG(MonthlyRate),0) as 'Average Monthly Rate'
FROM dbo.EmployeeAttrition
WHERE Attrition = 'Yes' and Gender = 'Male'

SELECT ROUND(AVG(HourlyRate),0) as 'Average Hourly Rate', ROUND(AVG(DailyRate),0) as 'Average Daily Rate', ROUND(AVG(MonthlyIncome),0) as 'Average Monthly Income', ROUND(AVG(MonthlyRate),0) as 'Average Monthly Rate'
FROM dbo.EmployeeAttrition
WHERE Attrition = 'Yes' and Gender = 'Female'

--Looking at these two results side by side we can see that wages for Attrition employees are nearly identical based on gender, 
--showing the company is doing very well at handling equality.

--Show Highest and Lowest wages
SELECT MAX(HourlyRate) as 'Hourly Rate', MAX(DAILYRATE) as 'Daily Rate', MAX(MonthlyIncome) as 'Monthly Income', MAX(MonthlyRate) as 'Monthly Rate'
FROM dbo.EmployeeAttrition
WHERE Attrition = 'Yes' 

SELECT MIN(HourlyRate) as 'Hourly Rate', MIN(DAILYRATE) as 'Daily Rate', MIN(MonthlyIncome) as 'Monthly Income', MIN(MonthlyRate) as 'Monthly Rate'
FROM dbo.EmployeeAttrition
WHERE Attrition = 'Yes'

--The average Attrition employee makes a smaller DailyRate and Monthly Income than the average of all employees. 
--However, Hourly Rate and Monthly Rate seem to be about the same. 


---TRAVEL

--Number of Total Employees and Attrition Employees that Travel Frequently, Rarely and Not at all
SELECT Distinct BusinessTravel, Count(*) as 'Total Number of Employees that Travel', (SELECT COUNT(*) 
										   FROM dbo.EmployeeAttrition b 
										   WHERE b.BusinessTravel=a.BusinessTravel AND Attrition = 'Yes') as 'Number of Attrition of Employees that Travel'
FROM dbo.EmployeeAttrition a
GROUP BY BusinessTravel
--Number of Attrition Employees that Travel Frequently, Rarely and Not at all AND the percent out of Total Employees that Travel by Category
SELECT Distinct BusinessTravel, (SELECT Count(*) 
								 FROM dbo.EmployeeAttrition b 
								 WHERE b.BusinessTravel=a.BusinessTravel) as 'Total Number of Employees that Travel', 
				CASE WHEN BusinessTravel = 'Travel_Frequently' THEN Count(*)
					      WHEN BusinessTravel = 'Travel_Rarely' THEN Count(*)
						  WHEN BusinessTravel = 'Non-Travel' THEN Count(*)
						  ELSE NULL END as 'Number of Attrition Employees',
			    CASE WHEN BusinessTravel = 'Travel_Frequently' THEN ROUND(Count(*)/(SELECT CAST(Count(*) as Float)
												FROM dbo.EmployeeAttrition b 
												WHERE b.BusinessTravel=a.BusinessTravel)*100,0)
					      WHEN BusinessTravel = 'Travel_Rarely' THEN ROUND(Count(*)/(SELECT CAST(Count(*) as Float)
													FROM dbo.EmployeeAttrition b 
													WHERE b.BusinessTravel=a.BusinessTravel)*100,0)
						  WHEN BusinessTravel = 'Non-Travel' THEN ROUND(Count(*)/(SELECT CAST(Count(*) as Float)
													  FROM dbo.EmployeeAttrition b 
													  WHERE b.BusinessTravel=a.BusinessTravel)*100,0)
						  END as 'Percent of Total Employees That Travel by Category',
				ROUND(AVG(MonthlyIncome),0) as 'Average Monthly Income'
FROM dbo.EmployeeAttrition a
WHERE attrition = 'YES' 
GROUP BY BusinessTravel 
ORDER BY BusinessTravel DESC
--Travel_Frequently = 69 (25% of total), Travel_Rarely = 156 (15% of total), Non-Travel = 12 (8% of total)
--Average Monthly Income for Frequent Travel seems to be lower than the Rarely and Non-Travel which could suggest looking into other compensations to make up for the higher amount of travel.

---DEPARTMENT

--Employees per Department
SELECT DISTINCT DEPARTMENT, COUNT(DEPARTMENT) as  'Employees per Department'
FROM dbo.EmployeeAttrition
GROUP BY Department

SELECT DISTINCT DEPARTMENT, COUNT(DEPARTMENT) as 'Attrition Employees per Department'
FROM dbo.EmployeeAttrition
WHERE Attrition = 'Yes'
GROUP BY Department


--Attrition Rate per Department
SELECT DISTINCT Department, COUNT(*) as 'Employees by Department',(SELECT COUNT(*)
								   FROM dbo.EmployeeAttrition b
								   WHERE b.Department=a.Department AND Attrition = 'Yes') AS 'Attrition Employees by Department', 
										        (SELECT CAST(COUNT(*) AS FLOAT)
											 FROM dbo.EmployeeAttrition b
										         WHERE b.Department=a.Department AND Attrition = 'Yes')/CAST(COUNT(*) AS FLOAT)*100 AS 'Attrition Rate of Total Education by Category'
FROM dbo.EmployeeAttrition a
GROUP BY Department
ORDER BY 'Employees by Department' desc

--R&D 14%, Sales 21% and HR less than 19%
--Sales in most industries tends to run high. However Human resources seems a bit higher than normal so we can run that with a few other factors.

SELECT Department, Count(*) 'Attrition Employees'
FROM dbo.EmployeeAttrition
WHERE Attrition IN ('YES') 
	AND Department LIKE 'Hu%'
	AND MonthlyIncome <= (Select AVG(MonthlyIncome)
			      FROM dbo.EmployeeAttrition
		              WHERE Department LIKE 'Hum%')
	AND JobLevel = 1
GROUP BY DEPARTMENT
--10 of the 12 Attritions for Human Rerouces are due to Monthly Income being less than the Average and Job Level at 1.
--So we can look at either increasing wages or finding better training to have employees move up.


---Age
--Average Age of Attrition employee = 34
SELECT ROUND(AVG(Age),0) as 'Average Age of Attrition Employees'
FROM dbo.EmployeeAttrition 
WHERE Attrition = 'Yes'

--Employee Attritions Per Age Range
SELECT CASE WHEN Age <= 29 THEN '18-29'
			  WHEN Age >= 30 AND Age<=39 THEN '30-39'
			  WHEN AGE >= 40 AND Age<=49 THEN '40-49'
			  WHEN AGE >=50 AND AGE <=59 THEN '50-59'
			  ELSE '60 OR OLDER'
			  END as 'Age Range',
		COUNT(*) as 'Number of employee Attritions per Age Range'
FROM dbo.EmployeeAttrition
WHERE Attrition = 'Yes' AND YearsAtCompany >= 1 and JobLevel = 3
GROUP BY CASE WHEN Age <= 29 THEN '18-29'
			  WHEN Age >= 30 AND Age<=39 THEN '30-39'
			  WHEN AGE >= 40 AND Age<=49 THEN '40-49'
			  WHEN AGE >=50 AND AGE <=59 THEN '50-59'
			  ELSE '60 OR OLDER'
			  END
--18-39 Year olds have the highest rate of Attrition
--By zooming into the search by adding Years at Comapany and Job Level we can see that the higher the Job Level the less Attrition

---EDUCATION

SELECT DISTINCT EducationField, (SELECT COUNT(*) 
				 FROM dbo.EmployeeAttrition b
				 WHERE b.EducationField=a.EducationField) as 'Total Employees by Education Field', 
				              (SELECT ROUND(AVG(MonthlyIncome),0) 
						FROM dbo.EmployeeAttrition b
						WHERE b.EducationField=a.EducationField) as 'Average Monthly Income',
		COUNT(EducationField) as 'Attrition Employees by Education Field',
		ROUND(AVG(MonthlyIncome),0) as 'Average Monthly Income of Attrition Employee',
		100-(ROUND(AVG(MonthlyIncome),0)/(SELECT ROUND(AVG(MonthlyIncome),0) 
						  FROM dbo.EmployeeAttrition b
						  WHERE b.EducationField=a.EducationField)*100) AS 'Perfect Difference in Average Monthly Income Between Attrition and Non-Attrition Employees',
		ROUND(AVG(Age),0) as 'Average age of Attrition Employee',
		ROUND(AVG(JobLevel),0) as 'Average Job Level'
FROM dbo.EmployeeAttrition a
WHERE Attrition = 'Yes'
GROUP BY EducationField


SELECT DISTINCT Education, COUNT(*) as 'Employees by Education Level', ROUND(AVG(MonthlyIncome),0) as 'Average Monthly Income', (SELECT COUNT(*)
																FROM dbo.EmployeeAttrition b
																WHERE b.Education=a.Education AND Attrition = 'Yes') AS 'Attrition employees by Education',
																		(SELECT ROUND(AVG(MonthlyIncome),0)
																		 FROM dbo.EmployeeAttrition b
																		 WHERE b.Education=a.Education AND Attrition = 'Yes') as 'Average Monthly Income of Attrition Employees',
																		              100-(SELECT ROUND(AVG(MonthlyIncome),0)
																				   FROM dbo.EmployeeAttrition b
																				   WHERE b.Education=a.Education AND Attrition = 'Yes')/ROUND(AVG(MonthlyIncome),0)*100 'Perfect Difference in Average Monthly Income Between Attrition and Non-Attrition Employees',
																						(SELECT CAST(COUNT(*) AS FLOAT)
																						 FROM dbo.EmployeeAttrition b
																						 WHERE b.Education=a.Education AND Attrition = 'Yes')/CAST(COUNT(*) AS FLOAT)*100 AS 'Attrition Rate of Total Education by Category',  
																								(SELECT ROUND(AVG(Age),0) 
																								FROM dbo.EmployeeAttrition b
																								WHERE b.Education=a.Education AND Attrition = 'Yes') as 'Average age of Attrition Employees by Education',
																										(SELECT ROUND(AVG(JobLevel),0) 
																										FROM dbo.EmployeeAttrition b
																										WHERE b.Education=a.Education AND Attrition = 'Yes') as 'Average Job Level'
FROM dbo.EmployeeAttrition a
GROUP BY Education
ORDER BY 'Employees by Education Level' desc

--Regardless of Education Level and Field, there is a big difference in Average Monthly Income for the Attrition employees. with on average them making over 25% less.


---Next we can look at relationship between Job Satisfaction to Involvement and pay.
SELECT JobSatisfaction, JobInvolvement, count(*)
FROM dbo.EmployeeAttrition
WHERE Attrition = 'Yes' and MonthlyIncome > (SELECT AVG(MonthlyIncome)
					     FROM dbo.EmployeeAttrition)
GROUP BY JobSatisfaction, JobInvolvement

SELECT JobSatisfaction, JobInvolvement, count(*)
FROM dbo.EmployeeAttrition
WHERE Attrition = 'Yes' AND MonthlyIncome < (SELECT AVG(MonthlyIncome)
					     FROM dbo.EmployeeAttrition)
GROUP BY JobSatisfaction, JobInvolvement

--These two tables show if attrition employees make a Monthly Income less than or greater than the average company pay. 
--It shows that regardless of combination of Job Satisfaction to Job Involvement, there is 3 to 4 times higher change of employee attrition.
