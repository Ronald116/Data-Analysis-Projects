CREATE TABLE employee (
	eeid text,
	fullName	text,
	jobTitle	text,
	department	text,
	businessUnit	text,
	gender	text,
	ethnicity	text,
	age	serial,
	hireDate	date,
	annualSalary	numeric(10,2),
	bonus	numeric(10,2),
	country	text,
	city	text,
	exitDate	date
);

COPY employee
FROM 'E:\DATA_ANALYTICS\Data-Analysis-Projects\Excel\Employee Capstone Project\EmployeeSampleData\employee.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

SELECT * FROM employee;

-- Analysis
--1. Employee Demogrphics

--Number of employees by department
SELECT
	department,
	COUNT(*) AS number_of_employee
FROM
	employee
GROUP BY
	1
ORDER BY 1;

--By country
SELECT
	country,
	COUNT(*) AS number_of_emp
FROM
	employee
GROUP BY 1
ORDER BY 1;

--By gender
SELECT
	gender,
	COUNT(*) AS number_of_emp
FROM
	employee
GROUP BY 1
ORDER BY 1;


-- 2. Compensation and Rewards
-- total salary and average by department
SELECT
	department,
	SUM(annualSalary) AS total_salary,
	ROUND(AVG(annualSalary),2) AS avg_salary
FROM
	employee
GROUP BY 1
ORDER BY 2,3;

--by country
SELECT
	country,
	SUM(annualSalary) AS total_salary,
	ROUND(AVG(annualSalary),2) AS average_salary
FROM
	employee
GROUP BY 1
ORDER BY 2,3;

--department with the highest bonus
SELECT
	department,
	SUM(bonus) AS bonus
FROM
	employee
GROUP BY 1
ORDER BY 2 DESC;

--pay gap between male and female employees
SELECT
    AVG(CASE WHEN gender = 'male' THEN annualSalary END) -
    AVG(CASE WHEN gender = 'female' THEN annualSalary END) AS salary_gap
FROM employee;

-- Tenure and Retention
-- average number of years employees have worked
SELECT
	ROUND(
	AVG(
	EXTRACT(YEAR FROM AGE(exitDate, hireDate))
	),2
	) AS ag_years_worked
FROM
	employee
WHERE
	exitDate IS NOT NULL;

--departments with the highest turnovers
SELECT
	department,
	COUNT(exitDate) AS turnover
FROM
	employee
GROUP BY 1
ORDER BY 2 DESC;

--employees employed each year
SELECT
	EXTRACT(YEAR FROM hireDate) AS hiredate,
	COUNT(*) AS number_of_emp
FROM
	employee
GROUP BY 1
ORDER BY 1 ASC;


