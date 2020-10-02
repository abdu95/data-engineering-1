-- create table students
CREATE TABLE students
(gender VARCHAR(32),
race VARCHAR(32),
parental_level VARCHAR(32),
lunch VARCHAR(32),
test_prep VARCHAR(32),
math_score VARCHAR(32),
reading_score VARCHAR(32),
writing_score VARCHAR(32)); 

-- load CSV
LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/StudentsPerformance.csv' 
INTO TABLE students 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(gender, race, parental_level, lunch, test_prep, math_score, reading_score, writing_score);

-- in case a problem with table, delete it
-- DROP TABLE students;

-- source for a dataset
-- https://www.kaggle.com/spscientist/students-performance-in-exams