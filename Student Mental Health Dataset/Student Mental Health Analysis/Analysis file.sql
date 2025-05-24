# Problem Statement 
	-- "The Institution seeks to investigate the factors infleuncing student academic performance, with particular interest in 
    -- examining the potential impact of marital status and mental health conditions such as depression, anxiety and panic attack"
 
/* Project Goal */
	-- The expectation of the institution from the project is to increase student Perfromance


/* Important KPI we would address */
	-- 1. The Total Number Of Surveyed Student
    -- 2. THe total Numbers of Student with Depression, Anxiety and Panic Attacks
    -- 3. Total Number Of Married Student and Single Student
/* Questions to Solve Our Problem Statemnt */
	-- 1. What is the distribution of student across all grades 
    -- 2. Does Marital Status influence student Performance
    -- 2. What is the Infleunce of Depression Anxiety and Panic Attack On student Performance
	-- 3. Does Level or Department have any infleunce on student Performance 
    
    
    
    



# Checking the length of the dataset i Am working with
select
	count(*)
from
	random_dataset.`student mental health`;
    
-- This survey dataset contains 100 rows and information of different student
    
/* Checking the dataset to understand the columns and rows i am working with */

select
	*
from
	random_dataset.`student mental health`;
    
/* we want to change the table name into name that would be error free for analysis and easy to read */
    
alter table random_dataset.`student mental health`
rename column `What is your course?` to `Course`,
rename column `Your current year of Study` to `Level`,
rename column `What is your CGPA?` to `CGPA`,
rename column `Marital status` to `Marital_status`,
rename column `Do you have Depression?` to `Depression`,
rename column `Do you have Anxiety?` to `Anxiety`,
rename column `Do you have Panic attack?` to `Panic_attack`,
rename column `Did you seek any specialist for a treatment?` to `Specialist_Requested`;

/* checking each rows and columns for missings values and outliers*/
select
	*
from 
	random_dataset.`student mental health`
where
	Timestamp is null or
    Gender is null or 
    Age is null or 
    Course is null or 
    Level is null or
    CGPA is null or
    Marital_status is null or
    Depression is null or
    Anxiety is null or 
    Panic_attack is null or
    Specialist_Requested is null ;
    
-- After looking into every row and column, we discover there are no missing value in any of the columns and rows


/* Looking into the rows and columns to confirm if the dataset are in the right format to aid smooth analysis */
SHOW COLUMNS FROM `student mental health` FROM random_dataset;

-- EVERY NEEDED COLUMNS ARE IN THE RIGHT FORMAT FOR ANALYSIS


/* CHECKING THE UNIQUE GENDERS WE ARE WORKING WITH AND TO SEE IF THERE IS ANY OUTLIERS IN EACH COLUMNS AND TO CHECK FOR BIAS */
SELECT
	distinct Gender,
    COUNT(Gender) AS count_of_student
FROM
	random_dataset.`student mental health`
GROUP BY
	Gender
ORDER BY
	Gender;
-- We Have Two Gender Group in our dataset and from the dataset
-- WE have more information on Female student in which we have 75 female and 25 male student

/* CHECKING THE UNIQUE AGE WE ARE WORKING WITH AND TO SEE IF THERE IS ANY OUTLIERS IN EACH COLUMNS AND TO CHECK FOR BIAS */
SELECT
	distinct Age,
    COUNT(AGE) AS count_of_student
FROM
	random_dataset.`student mental health`
GROUP BY
	Age
ORDER BY
	Age asc;
-- WE HAVE STUDENT WITHIN THE AGE GROUP OF 18- 24 YEARS OLD
-- We Have more information on student who are 18 years, 19 years, 24 years which indicate data collection bias on that level
-- This Can skew our end result if we are planning to look into depression in student by age group because we do not have enough
-- Information on the Other Age Group


/* CHECKING THE STUDENT DEPARTMENT WE ARE WORKING WITH AND TO SEE IF THERE IS ANY OUTLIERS IN EACH COLUMNS AND TO CHECK FOR BIAS */
SELECT
	distinct Course,
    count(Course) AS count_of_student
FROM
	random_dataset.`student mental health`
GROUP BY
	Course
ORDER BY
	Course;

-- WE HAVE Little to No Student from Majority of the Department and More student from department like
-- 1. BCS 2. BIT 3. ENGINEERING
-- WE Also have many incorrect input which neeeds to be replace
	/* 
		1. 'engin' to 'Engineering'
		2. 'Engine' to 'Engineering'
        3. 'Fiqh' to 'Fiqh fatwa '
        4. 'Laws' to 'Law'
        5. 'Pendidikan Islam ' to 'Pendidikan Islam'
    */
    
 /* Finding And Replacing the wrong input */
 
UPDATE random_dataset.`student mental health`

SET
	Course = 'Engineering'
    
WHERE
		Course = 'engin'
		or Course = 'Engine';
    
UPDATE random_dataset.`student mental health`

SET
	Course = 'Fiqh fatwa '
    
WHERE
		Course = 'Fiqh';

UPDATE random_dataset.`student mental health`

SET
	Course = 'Law'
    
WHERE
		Course = 'Laws';

UPDATE random_dataset.`student mental health`

SET
	Course = 'Pendidikan Islam'
    
WHERE
	Course = 'Pendidikan Islam ';
    

UPDATE random_dataset.`student mental health`
SET
	CGPA = '3.50 - 4.00'
WHERE
	CGPA = '3.50 - 4.00 ';


/* Checking the uniques values to check the changes were effective */

SELECT
	distinct Course,
    count(Course) AS count_of_student
FROM
	random_dataset.`student mental health`
GROUP BY
	Course
ORDER BY
	Course;
    
-- Done Cleaning the Course Row
		
    
    

/* CHECKING THE STUDENT LEVEL WE ARE WORKING WITH AND TO SEE IF THERE IS ANY OUTLIERS IN EACH COLUMNS AND TO CHECK FOR BIAS */
SELECT
	distinct Level,
    count(Course) AS count_of_student
FROM
	random_dataset.`student mental health`
GROUP BY
	Level
ORDER BY
	Level;

-- WE HAVE STUDENT WITHIN THE AGE GROUP OF 18- 24 YEARS OLD

SELECT
	*
FROM
	random_dataset.`student mental health`;
    
    

-- KPI 1
-- 1. The Total Number Of Surveyed Student

SELECT
	count(*) as Num_Of_Survery_Student
FROM
	random_dataset.`student mental health`;
    
-- KPI 2
-- 2. THe total Numbers of Student with Depression, Anxiety and Panic Attacks

SELECT
	SUM(case when Depression = "Yes" then 1 else 0 end) as Depressed_student
FROM
	random_dataset.`student mental health`;

-- 35 DEPRESSED STUDENT
    
SELECT
	SUM(case when Anxiety = "Yes" then 1 else 0 end) as Student_With_Anxiety
FROM
	random_dataset.`student mental health`;	

-- 34 STUDENT WITH ANXIETY

SELECT
	SUM(case when Panic_Attack = "Yes" then 1 else 0 end) as Student_With_Panic_attack
FROM
	random_dataset.`student mental health`;

-- 33 STUDNET WITH PANIC ATTACKS

-- KPI 3
-- 3. total Number Of Married Student and Single Student
	
SELECT 
		count(Case when Marital_status = "Yes" then Marital_Status else NULL end) as Married_Student
FROM
	random_dataset.`student mental health`;
    
-- 16 MARRIED STUDENT

    
SELECT 
		count(Case when Marital_status = "No" then Marital_Status else NULL end) as SINGLE_STUDENT
FROM
	random_dataset.`student mental health`;
    
-- 84 SINGLE STUDENT 


/* 1. What is the distribution of student across all grades */

SELECT
    CGPA,
    COUNT(CGPA) AS ToTal_Student
FROM
	random_dataset.`student mental health`
GROUP BY
	CGPA
ORDER BY
	CGPA;

	






/* 2. Does Marital Status influence  student Performance */
SELECT
	Distinct CGPA,
    count(case when Marital_status = "Yes" then CGPA else NULL end) as MARRIED,
    count(case when Marital_status = "No" then CGPA else NULL end) as SINGLE
FROM
	random_dataset.`student mental health`
GROUP BY
	CGPA
ORDER BY
	CGPA;
    
-- CONSIDERING THE FACT THAT WE HAD MORE OF OUR DATA ON SINGLE STUDENT THAN MARRIED STUDENT(WE HAVE MORE SINGLE STUDENT DOING WELL)
-- BUT IF WE ARE LOOKING AT THE GENRAL VIEW OF THINGS BEING THE FACT WE HAD DATA ON 16 MARRIED STUDENT AND THEY ALL ARE ABOVE 
-- 2.5 CGPA AVERAGE, WE CAN SAY THAT BEING MARRIED OR SINGLE DOES NOT REALLY INFLUENCE STUDENT PERFORMACE EVEN THOUGH THERE ARE SOME
-- STUDENT THAT PERFORM BADLY CONPARED BUT THEY ARE LESS THEN 10 PERVENT OF THE STUDENT POPULATION, WE HAVE 5 STUDENT DOING BELOW
-- THE 2.50 CGPA



    
/* 3. What is the Infleunce of Depression Anxiety and Panic Attack On student Performance */

SELECT
	Distinct CGPA,
    count(case when Depression = "Yes" then CGPA else NULL end) as Depressed,
    count(case when Depression = "No" then CGPA else NULL end) as NOT_Depressed
FROM
	random_dataset.`student mental health`
GROUP BY
	CGPA
ORDER BY
	CGPA;
-- I ALSO LOOKED INTO THE RELATIONSHIP BETWEEN DEPRESSION AND STUDENT GRADES AND DISOVERED THAT DEPRESSION HAD NOTHING TO DO WITH STUDENT GRADES
-- WE EVEN HAVE A HIGHER PERCENTAGE OF STUDENT DOING WELL AND ARE DEPRESSED THAN THE ONES THAT ARE NOT DOING WELL

SELECT
	Distinct CGPA,
    count(case when Anxiety = "Yes" then CGPA else NULL end) as Student_With_Anxiety,
    count(case when Anxiety = "No" then CGPA else NULL end) as Student_Without_Anxiety
FROM
	random_dataset.`student mental health`
GROUP BY
	CGPA
ORDER BY
	CGPA;
    
-- I ALSO LOOKED INTO ANXIETY AND HOW IT INFLUENCE STUDENT PERFORMANCE AND I NOTICE THAT IT DOES NOT HAVE ANY NEGATIVE THING TO DO WITH STUDENT
-- PERFORMANCE, WE HAVE A MORE  STUDENT WITHOUT ANXIETY FAILING THAN THE PERCENTAGE OF STUDENT WE HAVE FAILING EVEN THOUGH
-- IN THE GENERAL SENSE, MAJORITY OF THE STUDENT ARE DOING WELL.


SELECT
	Distinct CGPA,
    count(case when Panic_attack = "Yes" then CGPA else NULL end) as Student_With_Panic_attack,
    count(case when Panic_attack = "No" then CGPA else NULL end) as Student_Without_Panic_attack
FROM
	random_dataset.`student mental health`
GROUP BY
	CGPA
ORDER BY
	CGPA;
    
-- I FOUND THE SAME CORRELATION WITH WHAT I FOUND ON THE DEPESSION AND ANXIETY MENTAL HEALTH CONDITION

/* -- 5. Does Level or Department have any infleunce on student Performance as well */

SELECT
	Distinct CGPA,
    count(case when Level = "year 1" then CGPA else NULL end) as year_1,
    count(case when Level = "year 2" then CGPA else NULL end) as year_2,
    count(case when Level = "year 3" then CGPA else NULL end) as year_3,
    count(case when Level = "year 4" then CGPA else NULL end) as year_4
FROM
	random_dataset.`student mental health`
GROUP BY
	CGPA
ORDER BY
	CGPA;

-- WE COULD NOT FIND ANY CORRELATION WHATSOEVER ON STUDENT GRADES AND THE LEVELS THEY ARE IN, BUT WE NOTICED THAT MOST STUDENT WERE
-- DOING WELL REGARDLESS OF THIER LEVELS
SELECT
	Distinct Course,
    count(case when CGPA = "0 - 1.99" then CGPA else NULL end) as "0 - 1.99",
    count(case when CGPA = "2.00 - 2.49" then CGPA else NULL end) as "2.00 - 2.49",
    count(case when CGPA = "2.50 - 2.99" then CGPA else NULL end) as "2.50 - 2.99",
    count(case when CGPA = "3.00 - 3.49" then CGPA else NULL end) as "3.00 - 3.49",
    count(case when CGPA = "3.50 - 4.00" then CGPA else NULL end) as"3.50 - 4.00"
FROM
	random_dataset.`student mental health`

GROUP BY
	Course
HAVING
	count(Course) > 4
ORDER BY
	 "0 - 1.99" asc,
	"2.00 - 2.49" asc,
	"2.50 - 2.99" asc,
	"3.00 - 3.49" asc,
	"3.50 - 4.00" asc;
    
-- I DECIDED TO LOOK INTO THE TOP FOUR  DEPARTMENT WITH MORE THAN 5 STUDENT IN OUT DATASET TO CONFIRM HOW GRADES ARE DISTRIBUTED
-- IN THIS DEPARTMENT AND I NOTICED THAT MAJORITY OF THOSE DEPARTMENT HAVE STUDENT MOSTLY PERFORMING WELL SO DEPARTMENT DOES NOT INFLEUNCE
-- THE GRADE OF STUDENT ACCORDING TO OUR DATASET 


/* Creating a table for my power_bi presentation */
SELECT 
	Gender,
    Age,
    Course,
    Level,
    CGPA,
    (CASE WHEN Marital_status = 'Yes' Then "Married" else "Single" end )as Marital_Status,
    (CASE WHEN Depression = 'Yes' Then "Depressed" else "Not_Depressed" end) as Depression,
    (CASE WHEN Anxiety = 'Yes' then "With_Anxiety" else "Without_Anxiety" end) as Anxiety,
    (CASE WHEN Panic_attack = 'Yes' then "With_Panic_attacks" else "Without_Panic_acttack" end) as Panic_Attack,
    Specialist_requested
FROM
	random_dataset.`student mental health`

