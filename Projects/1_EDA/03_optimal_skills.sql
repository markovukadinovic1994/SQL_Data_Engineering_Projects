/*
Question: What are the most optimal skills for data engineers—balancing both demand and salary?

- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on remote Data Engineer positions with specified annual salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately, rather than letting rare, outlier skills distort the results.
    - The natural log transformation ensures that both high-salary and widely in-demand skills surface as the most practical and valuable to learn for data engineering careers.
*/

SELECT 
    sd.skills AS skill,
    ROUND(MEDIAN(jpf.salary_year_avg),2) AS median_salary, 
    --COUNT(jpf.salary_year_avg) AS demand_count,
    --LN(COUNT(jpf.salary_year_avg)) AS log_demand_count,
    ROUND(MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*))/100_0, 2) AS optimal_score
FROM job_postings_fact as jpf
INNER JOIN skills_job_dim as sjd 
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim as sd 
    ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short = 'Data Engineer' 
    AND jpf.job_work_from_home = TRUE
    AND jpf.salary_year_avg IS NOT NULL
GROUP BY 
    sd.skills
HAVING 
    COUNT(jpf.*) >= 100
ORDER BY 
    optimal_score DESC
LIMIT 30;

/*
┌────────────┬───────────────┬───────────────┐
│   skill    │ median_salary │ optimal_score │
│  varchar   │    double     │    double     │
├────────────┼───────────────┼───────────────┤
│ terraform  │      184000.0 │        968.33 │
│ python     │      135000.0 │         949.4 │
│ aws        │     137320.31 │        914.98 │
│ sql        │      130000.0 │        913.67 │
│ airflow    │      150000.0 │        893.38 │
│ spark      │      140000.0 │        870.88 │
│ snowflake  │      135500.0 │        824.14 │
│ kafka      │      145000.0 │        823.13 │
│ azure      │      128000.0 │         788.9 │
│ java       │      135000.0 │        771.35 │
│ scala      │     137290.48 │        756.39 │
│ kubernetes │      150500.0 │        751.06 │
│ git        │      140000.0 │        747.26 │
│ databricks │      132750.0 │        741.21 │
│ redshift   │      130000.0 │        729.71 │
│ gcp        │      136000.0 │        717.82 │
│ hadoop     │      135000.0 │        713.92 │
│ nosql      │      134415.0 │        707.38 │
│ pyspark    │      140000.0 │        703.34 │
│ docker     │      135000.0 │        670.92 │
│ mongodb    │      135750.0 │        666.89 │
│ go         │      140000.0 │        661.83 │
│ r          │      134775.0 │         659.1 │
│ github     │      135000.0 │        653.97 │
│ bigquery   │      135000.0 │        649.64 │
│ mysql      │      130500.0 │        602.27 │
│ postgresql │      122500.0 │        595.33 │
│ sql server │      120000.0 │        592.14 │
│ tableau    │      115000.0 │        586.48 │
│ flow       │      125500.0 │        586.44 │
├────────────┴───────────────┴───────────────┤
│ 30 rows                          3 columns │
└────────────────────────────────────────────┘
Despite the high demand for skills like SQL and Python, the optimal score calculation reveals that skills such as 
Terraform, AWS, and Airflow provide a better balance of demand and salary. 
This suggests that data engineers looking to maximize their career prospects should consider focusing on these skills.

*/


/* Right after we updated our database with the most recent job postings, we can see some changes:
┌────────────┬───────────────┬───────────────┐
│   skill    │ median_salary │ optimal_score │
│  varchar   │    double     │    double     │
├────────────┼───────────────┼───────────────┤
│ python     │      135000.0 │        973.06 │
│ sql        │      129500.0 │        935.04 │
│ aws        │      135000.0 │        924.77 │
│ airflow    │      150000.0 │        923.86 │
│ terraform  │      167000.0 │         903.0 │
│ spark      │      140000.0 │        894.63 │
│ snowflake  │      135000.0 │        847.85 │
│ kafka      │      145000.0 │        846.47 │
│ kubernetes │      155000.0 │        805.77 │
│ azure      │      125000.0 │        798.36 │
│ java       │      135000.0 │        790.05 │
│ scala      │      137500.0 │        776.73 │
│ databricks │      130000.0 │        769.46 │
│ git        │      139000.0 │        761.81 │
│ pyspark    │      140000.0 │        754.47 │
│ redshift   │      130000.0 │        750.69 │
│ gcp        │      135000.0 │        737.62 │
│ hadoop     │      135000.0 │        727.52 │
│ nosql      │      132500.0 │        715.85 │
│ docker     │      135500.0 │         694.3 │
│ go         │      140000.0 │        691.83 │
│ mongodb    │      135000.0 │        683.45 │
│ r          │      133637.5 │        662.28 │
│ pandas     │      140000.0 │        661.83 │
│ bigquery   │      126000.0 │        644.11 │
│ sql server │      121920.0 │        640.99 │
│ looker     │      136000.0 │         626.3 │
│ github     │      127500.0 │        623.52 │
│ tableau    │      117500.0 │        617.14 │
│ mysql      │      130000.0 │        616.84 │
├────────────┴───────────────┴───────────────┤
│ 30 rows                          3 columns │
└────────────────────────────────────────────┘  
*/   