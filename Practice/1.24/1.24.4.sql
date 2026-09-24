-- When you initially populated the job_skill_priorities table, the skill_name and priority_lvl columns were left blank (NULL). You've been tasked to fill in these missing values by pulling them directly from your priority_skills staging table. A MERGE statement is the perfect tool to match the records and update the empty columns in one step.

-- Task

-- Create a SQL file in the Lesson folder named 1.24.4.sql.
-- Use the company_jobs database.
-- Write a MERGE statement that targets the job_skill_priorities table.
-- Use the staging.priority_skills table as the source of the data.
-- Match the records between the two tables using the skill_id column.
-- When a match is found between the source and the target, update the skill_name and priority_lvl in the target table with the values from the source table.
-- Verify the table was updated correctly.
-- Hint
-- Using table aliases like tgt and src makes it much easier to reference columns in the ON and SET clauses.
-- The WHEN MATCHED clause only triggers for rows where the join condition evaluates to TRUE.



UPDATE staging.priority_skills SET priority_lvl = 1 WHERE skill_id = 0;
UPDATE staging.priority_skills SET priority_lvl = 2 WHERE skill_id = 1;



MERGE INTO main.job_skill_priorities AS tgt
USING staging.priority_skills AS src
ON tgt.skill_id = src.skill_id
WHEN MATCHED AND (tgt.priority_lvl <> src.priority_lvl OR tgt.priority_lvl IS NULL) THEN
    UPDATE SET 
        priority_lvl = src.priority_lvl,
        status = 'PRIORITY_CHANGE';
 