/*
**Question: What are the highest-paying skills for data engineers?** 

- Calculate the median salary for each skill required in data engineer positions
- Focus on remote positions with specified salaries
- Include skill frequency to identify both salary and demand
- Why?
    - Helps identify which skills command the highest compensation while also showing how common those skills are, providing a more complete picture for skill development priorities.
    - The median is used instead of the average to reduce the impact of outlier salaries.
*/


SELECT 
    sd.skills AS skill,
    ROUND(MEDIAN(jpf.salary_year_avg),2) AS median_salary,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact as jpf
INNER JOIN skills_job_dim as sjd 
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim as sd 
    ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short = 'Data Engineer' 
    AND jpf.job_work_from_home = TRUE
GROUP BY 
    sd.skills
HAVING 
    COUNT(jpf.*) >= 100
ORDER BY 
    median_salary DESC
LIMIT 30;

/*
┌────────────┬───────────────┬──────────────┐
│   skill    │ median_salary │ demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ rust       │      210000.0 │          232 │
│ golang     │      184000.0 │          912 │
│ terraform  │      184000.0 │         3248 │
│ spring     │      175500.0 │          364 │
│ neo4j      │      170000.0 │          277 │
│ gdpr       │      169615.5 │          582 │
│ zoom       │      168437.5 │          127 │
│ graphql    │      167500.0 │          445 │
│ mongo      │      162250.0 │          265 │
│ fastapi    │      157500.0 │          204 │
│ bitbucket  │      155000.0 │          478 │
│ django     │      155000.0 │          265 │
│ crystal    │      154223.5 │          129 │
│ atlassian  │      151500.0 │          249 │
│ c          │      151500.0 │          444 │
│ typescript │      151000.0 │          388 │
│ kubernetes │      150500.0 │         4202 │
│ node       │      150000.0 │          179 │
│ css        │      150000.0 │          262 │
│ ruby       │      150000.0 │          736 │
│ airflow    │      150000.0 │         9996 │
│ redis      │      149000.0 │          605 │
│ vmware     │     148798.25 │          136 │
│ ansible    │     148798.25 │          475 │
│ jupyter    │      147500.0 │          400 │
│ visio      │      146500.0 │          105 │
│ kafka      │      145000.0 │         6415 │
│ go         │      140000.0 │         1997 │
│ git        │      140000.0 │         4641 │
│ spark      │      140000.0 │        12799 │
├────────────┴───────────────┴──────────────┤
│ 30 rows                         3 columns │
└───────────────────────────────────────────┘
*/

/* Right after we updated our database with the most recent job postings, we can see some changes:

┌────────────┬───────────────┬──────────────┐
│   skill    │ median_salary │ demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ gdpr       │      183802.0 │          699 │
│ rust       │      171875.0 │          241 │
│ zoom       │      170937.5 │          157 │
│ spring     │      168469.0 │          402 │
│ terraform  │      167000.0 │         3513 │
│ graphql    │      167000.0 │          457 │
│ mongo      │      158000.0 │          282 │
│ kubernetes │      155000.0 │         4512 │
│ bitbucket  │      155000.0 │          501 │
│ django     │      155000.0 │          281 │
│ fastapi    │      152500.0 │          253 │
│ sheets     │      152500.0 │          144 │
│ typescript │      150500.0 │          445 │
│ ruby       │      150000.0 │          764 │
│ css        │      150000.0 │          279 │
│ airflow    │      150000.0 │        10678 │
│ node       │      150000.0 │          218 │
│ redis      │      149500.0 │          652 │
│ neo4j      │      149075.0 │          276 │
│ ansible    │     148798.25 │          527 │
│ vmware     │      147596.5 │          156 │
│ golang     │      147500.0 │          926 │
│ react      │      145750.0 │          538 │
│ splunk     │      145000.0 │          300 │
│ kafka      │      145000.0 │         6911 │
│ jupyter    │      143750.0 │          417 │
│ go         │      140000.0 │         2244 │
│ word       │      140000.0 │          658 │
│ pyspark    │      140000.0 │         5401 │
│ pandas     │      140000.0 │         3121 │
├────────────┴───────────────┴──────────────┤
│ 30 rows                         3 columns │
└───────────────────────────────────────────┘
*/ 