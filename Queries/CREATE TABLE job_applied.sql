CREATE TABLE job_applied (
    job_id INT,
    application_sent_date DATE,
    customer_resume BOOLEAN,
    resume_file_name VARCHAR(255),
    cover_letter_sent BOOLEAN,
    cover_letter_file_name VARCHAR,
    status VARCHAR(50)
);


INSERT INTO job_applied(
    job_id,
    application_sent_date,
    customer_resume,
    resume_file_name,
    cover_letter_sent,
    cover_letter_file_name,
    status
)
VALUES (1,
    '2024-02-01',
    true,
    'resume_01.pdf',
    true,
    'cover_letter_01.pdf',
    'submitted'
),(2,
    '2024-02-02',
    false,
    'resume_02.pdf',
    false,
    NULL,
    'interview scheduled'
),(3,
    '2024-02-03',
    true,
    'resume_04.pdf',
    false,
    NULL,
    'submitted'
),(4,
    '2024-02-04',
    false,
    'resume_04.pdf',
    false,
    NULL,
    'interview scheduled');

    SELECT * FROM job_applied;

    ALTER TABLE job_applied
    ADD contact VARCHAR(50);

    UPDATE job_applied
    SET contact = 'Erlich Bachman'
    WHERE job_id = 1;

