--This is known as grouping on PowerBI, Anyhwere = Remote, New York = Local
SELECT 
    job_title_short,
    job_location,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact;

SELECT 
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY
    location_category;

    -- Determine the size category ('Small', 'Medium', 'Large') for each company by first identifying the number of job postings they have. Use a subquery to calculate the total job postings per company. A company is considered 'Small', if it has less than 10 job postings, 'Medium' if the number of job postings is between 10 and 50, and 'Large'  if it is has more than 50 job postings. Implement a subquery to aggregate job counts per company before classifying them based on size.


SELECT 
    company_dim.company_id,
    company_dim.name AS company_name,
    CASE
        WHEN total_job_postings < 10 THEN 'Small'
        WHEN total_job_postings <= 50 THEN 'Medium'
        ELSE 'Large'
    END AS company_size
FROM 
    company_dim
JOIN (
    SELECT 
        company_id,
        COUNT(*) AS total_job_postings
    FROM 
        job_postings_fact
    GROUP BY 
        company_id
) AS job_counts ON company_dim.company_id = job_counts.company_id;


/*Find the count of the number of remote job postings per skill. Display the top 5 skills by their demand in rremote jobs, include skill_id, anme, and count of postings requiring the skill*/


    WITH remote_job_skills AS (
        SELECT 
            skill_id,
            COUNT(*) AS skill_count
        FROM
            skills_job_dim AS skills_to_job
        INNER JOIN job_postings_fact AS job_postings
        ON job_postings.job_id = skills_to_job.job_id
        WHERE job_postings.job_work_from_home = True 
        AND job_postings.job_title_short = 'Data Analyst'
        GROUP BY skill_id
    )

    SELECT 
        skills.skill_id,
        skills AS skill_name,
        skill_count
    FROM remote_job_skills
    INNER JOIN skills_dim AS skills 
    ON skills.skill_id = remote_job_skills.skill_id
    ORDER BY skill_id
    LIMIT 5;
 


