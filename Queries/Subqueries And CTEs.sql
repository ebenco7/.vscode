 SELECT
    company_id,
    name As company_dim
FROM    
    company_dim
WHERE company_id IN (
    SELECT
        company_id
    FROM
        job_postings_fact
    WHERE 
        job_no_degree_mention = TRUE
    ORDER BY company_id
)


--FInd the companies with the most job openings
--Get the total number of job posting, per company id, return the total number of jobs with the company name(company_id)

WITH company_job_count AS 
 (SELECT
    company_id,
    COUNT(*) AS total_jobs
FROM    
    job_postings_fact
GROUP BY
    company_id)

    SELECT company_dim.name AS company_name,
            company_job_count.total_jobs
    FROM company_dim
    LEFT JOIN company_job_count 
    ON company_job_count.company_id = company_dim.company_id
    ORDER BY total_jobs DESC;


-- Identify the top 5 skills that are more frequently mentioned in job postings. Use a subquery to find the skill IDs with the highest counts in the skills_job_dim table and then join this result with the skills_dim table to get the skill name.

SELECT top_skills.skill_id, skills_dim.skills
FROM skills_dim
JOIN (

SELECT skill_id
FROM skills_job_dim
GROUP BY skill_id
ORDER BY COUNT(*) DESC
LIMIT 5
) AS top_skills

ON skills_dim.skill_id = top_skills.skill_id;




SELECT skills
FROM skills_dim
LIMIT 5


