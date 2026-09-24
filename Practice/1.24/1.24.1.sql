CREATE TABLE IF NOT EXISTS staging.priority_skills (
  skill_id INT PRIMARY KEY,
  skill_name VARCHAR,
  priority_lvl INT
);


INSERT INTO staging.priority_skills (skill_id, skill_name, priority_lvl)
VALUES 
  (1, 'python', 1),
  (0, 'sql', 1),
  (183, 'tableau', 2);

 