/*UNION Operators combine result sets of two or more SELECT statement into a single result set.

UNION removes duplicate rows
UNION ALL includes all duplicaterows
Each SELECT statement within the UNION must have the same number of columns in the result sets with similar data types.*/


--Get job and companies from January

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs
    
UNION

--Get job and companies from February
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

UNION

--Get job and companies from March
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs;



SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs
    
UNION ALL

--Get job and companies from February
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

UNION ALL

--Get job and companies from March
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs;


--Get the corresponding skill and skill type for each job posting in q1, include those without any skills too.Why? Look at the skills and the type for each job in the first quuarteer that hs a salary > $70,000.

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs
WHERE salary_year_avg > 70000
    
UNION

--Get job and companies from February

SELECT skills_dim.skills FROM skills_dim
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs
WHERE salary_year_avg > 70000

UNION

--Get job and companies from March
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs
WHERE salary_year_avg > 70000;


--The Solution

SELECT skills_job_dim.skill, skills_job_dim.type
FROM skills_job_dim
JOIN 
        ( 
        SELECT
            job_title_short,
            company_id,
            job_location,
            job_id
        FROM
            january_jobs
        WHERE salary_year_avg > 70000
            
        UNION

        --Get job and companies from February

        
        SELECT
            job_title_short,
            company_id,
            job_location,
            job_id
        FROM
            february_jobs
        WHERE salary_year_avg > 70000

        UNION 

        --Get job and companies from March
        SELECT
            job_title_short,
            company_id,
            job_location,
            job_id
        FROM
            march_jobs
        WHERE salary_year_avg > 70000
        ) AS first_q1_sal 
ON skills_job_dim.job_id = first_q1_sal.job_id
JOIN 
    (
        SELECT COUNT(*), skills_job_dim.job_id
FROM skills_dim
LEFT JOIN skills_job_dim
ON skills_dim.skill_id = skills_job_dim.skill_id
GROUP BY skills_job_dim.job_id;
    )
ON skills_job_dim.job_id = 

ORDER BY skills_job_dim.skills;


SELECT 
    first_q1_sal.job_title_short,
    first_q1_sal.job_location,
    first_q1_sal.job_via,
    first_q1_sal.job_posted_date::DATE,
    first_q1_sal.salary_year_avg
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs) AS first_q1_sal
WHERE
    first_q1_sal.salary_year_avg > 70000 AND
    first_q1_sal.job_title_short = 'Data Analyst'
ORDER BY
    first_q1_sal.salary_year_avg DESC;
