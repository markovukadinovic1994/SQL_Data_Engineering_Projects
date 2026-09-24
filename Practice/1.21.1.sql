USE company_jobs;

CREATE TABLE IF NOT EXISTS dev.applications_fact (
    application_id INT PRIMARY KEY,
    candidate_id INT NOT NULL,
    job_id INT NOT NULL,
    date_applied DATE NOT NULL,
    application_status TEXT NOT NULL, 
    internal_candidate BOOLEAN NOT NULL,);

 INSERT INTO dev.applications_fact (application_id, candidate_id, job_id, date_applied, application_status, internal_candidate) VALUES
(1, 101, 1001, '2024-01-15', 'Pending', FALSE),
(2, 102, 1002, '2024-01-16', 'Reviewed', TRUE),
(3, 103, 1003, '2024-01-17', 'Interview Scheduled', FALSE),
(4, 104, 1004, '2024-01-18', 'Rejected', TRUE),
(5, 105, 1005, '2024-01-19', 'Hired', FALSE);


SELECT * FROM dev.applications_fact;


ALTER TABLE dev.applications_fact
ADD follow_up_timestamp TIMESTAMPTZ; 

SELECT * FROM dev.applications_fact;
