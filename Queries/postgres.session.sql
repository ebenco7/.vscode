SELECT * FROM job_postings_fact
LIMIT 10;

--This query returns date and timestamp
SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AS date
FROM job_postings_fact;

--This query returns only the date
SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date::DATE AS date
FROM job_postings_fact
LIMIT 5;

--To add time zone using UTC (Universal Time, Coordinated)

SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time_zone
FROM job_postings_fact
LIMIT 5;

--Extract field such as Day, Month, Year out of the date.
SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time_zone,
    EXTRACT (DAY FROM job_posted_date) AS date_day,
    EXTRACT (MONTH FROM job_posted_date) AS date_month,
    EXTRACT (YEAR FROM job_posted_date) AS date_year
FROM job_postings_fact
LIMIT 5;


/*To know the monthly trend for job title using the job title id, you aggregate the job_id and Group by the alias (date_month)*/
SELECT
   COUNT(job_id), 
    EXTRACT(MONTH FROM job_posted_date) AS date_month
FROM
    job_postings_fact
GROUP BY
    date_month;

/*To know the monthly trend for job title using the job title id, you aggregate the job_id and Group by the alias (date_month)*/
SELECT
   COUNT(job_id) AS job_posted_count, 
    EXTRACT(MONTH FROM job_posted_date) AS date_month
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    date_month
ORDER BY
    job_posted_count DESC;

    --Write a query to find the average salary both yearly(salary_year_avg) and hourly (salary_hour_avg) for job postings that were posted after June 1, 2023. Group the results by job schedule type.


SELECT 
    job_schedule_type,
    AVG(salary_year_avg) AS "Yearly Average Salary",
    AVG(salary_hour_avg) AS "Hourly Average Salary"
FROM 
    job_postings_fact
WHERE 
    job_posted_date > '2023-06-01'
GROUP BY 
    job_schedule_type;


--Write a query to count the number of job postings for each month in 2023, adjusting the job_posted_date to be in America/New_York time zone before extracting the month. Group by and order by month.

SELECT 
    job_schedule_type,
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'CST') AS month,
    EXTRACT(YEAR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'CST') AS year
FROM 
    job_postings_fact
WHERE 
        EXTRACT(YEAR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'CST') = 2023
GROUP BY 
    month,job_schedule_type, year 
ORDER BY 
    month;


--Write a query to find companies (include company name) that have posted jobs offering health insurance, where these postings were made in the second quarter of 2023. Use date extraction to filter by quarter.


SELECT 
    company_dim.name,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM 
    job_postings_fact
LEFT JOIN 
    company_dim
ON 
    job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_health_insurance = 'TRUE' AND EXTRACT(MONTH FROM job_posted_date) BETWEEN 4 AND 6
GROUP BY  
    company_dim.name, EXTRACT(MONTH FROM job_posted_date)
LIMIT 10;


