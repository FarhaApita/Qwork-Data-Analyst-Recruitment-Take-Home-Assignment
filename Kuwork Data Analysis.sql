-- Data cleaning not null data and filtered by Marketing Executive
SELECT
job_main.scrapedid,
job_location.location,
job_category.category,
job_type.type,
job_main.job_title,
job_main.career_level,
job_main.year_experience_min,
job_main.year_experience_max,
job_main.currency,
job_main.salary_min,
job_main.salary_max
FROM job_main
JOIN job_location
  ON job_main.scrapedid = job_location.scrapedid
JOIN job_category
  ON job_main.scrapedid = job_category.scrapedid
JOIN job_type
  ON job_main.scrapedid = job_type.scrapedid
 WHERE 
	 job_main.job_title = 'Marketing Executive' 
 AND job_main.year_experience_min  is not null 
 AND job_main.year_experience_max is not null 
 And job_main.career_level is not null
 AND job_main.currency is not null 
 AND job_main.salary_min is not null
 AND job_main.salary_max is not null;
 
-- Checking the job type
SELECT DISTINCT type FROM job_type;


-- Cleaning data and change the type column
UPDATE job_type
SET type = replace(type,'full time','fulltime');
-- 2
UPDATE job_type
SET type = replace(type,'full-time','fulltime');
-- 3
UPDATE job_type
SET type = replace(type,'full_time','fulltime');
-- 4
UPDATE job_type
SET type = replace(type,'full-time, permanent','fulltime');
-- 5
UPDATE job_type
SET	type = replace(type,'Full Time','fulltime');
-- 6
UPDATE job_type
SET type = replace(type,'permanent','fulltime');
-- 7
UPDATE job_type
SET type = replace(type,'karyawan tetap','fulltime');
-- 8
UPDATE job_type
SET type = replace(type,'contractor','contract');
-- 9
UPDATE job_type
SET type = replace(type,'contract/temp','contract');
-- 10
UPDATE job_type
SET type = replace(type,'contractual','contract');
-- 11
UPDATE job_type
SET type = replace(type,'Contract','contract');
-- 12
UPDATE job_type
SET type = replace(type,'karyawan kontrak','contract');
-- 13
UPDATE job_type
SET type = replace(type,'Internship','internship');
-- 14
UPDATE job_type
SET type = replace(type,'intern','internship');
-- 15
UPDATE job_type
SET type = replace(type,'full timeinternship','internship');
-- 16
UPDATE job_type
SET type = replace(type,'Permanent','fulltime');
-- 17
UPDATE job_type
SET type = replace(type,'internshipship','internship');
--18
UPDATE job_type
SET	type = replace(type,'fulltime, fulltime','fulltime');
-- 19
UPDATE job_type
SET type = replace(type,'part-time','part time');
-- 20
UPDATE job_type
SET type = replace(type,'part_time','part time');
-- 21
UPDATE job_type
SET type = replace(type,'fulltimepart time','part time');
-- 22
UPDATE job_type
SET	type = replace(type,'Part-time','part time');
-- 23
UPDATE job_type
SET	type = replace(type,'part timefulltime','part time');
-- 24
UPDATE job_type
SET	type = replace(type,'Temporary','temporary');
 
 
-- Range salary based on location
WITH BASE_SALARY_LOCATION
AS (
	SELECT
	job_main.scrapedid,
	job_location.location,
	CASE
		WHEN job_main.job_title LIKE '%Marketing Executive%' THEN 'Marketing Executive'
		ELSE job_main.job_title
		END AS job_title,
	job_main.currency,
	job_main.salary_min,
	job_main.salary_max
	FROM job_main
	JOIN job_location
	  ON job_main.scrapedid = job_location.scrapedid
	 WHERE 
		 job_main.job_title LIKE '%Marketing Executive%' 
	 AND job_main.year_experience_min  is not null 
	 AND job_main.year_experience_max is not null
	 And job_main.career_level is not null 
	 AND job_main.currency is not null 
	 AND job_main.salary_min is not null
	 AND job_main.salary_max is not null
)


SELECT location
	, currency
	, min(salary_min) as salary_min
	, max(salary_max) as salary_max
FROM BASE_SALARY_LOCATION
group by location, currency
 

-- Range salary based on job category
WITH BASE_SALARY_CATEGORY
AS (
	SELECT
	job_main.scrapedid,
	job_category.category,
	CASE
		WHEN job_main.job_title LIKE '%Marketing Executive%' THEN 'Marketing Executive'
		ELSE job_main.job_title
		END AS job_title,
	job_main.currency,
	job_main.salary_min,
	job_main.salary_max
	FROM job_main
	JOIN job_category
	  ON job_main.scrapedid = job_category.scrapedid
	 WHERE 
		 job_main.job_title LIKE '%Marketing Executive%' 
	 AND job_main.year_experience_min  is not null 
	 AND job_main.year_experience_max is not null
	 And job_main.career_level is not null 
	 AND job_main.currency is not null 
	 AND job_main.salary_min is not null
	 AND job_main.salary_max is not null
)


SELECT category
	, currency
	, min(salary_min) as salary_min
	, max(salary_max) as salary_max
FROM BASE_SALARY_CATEGORY
group by category, currency
 
 
-- Range Salary based on job type
WITH BASE_SALARY_TYPE
AS (
	SELECT
	job_main.scrapedid,
	job_type.type,
	CASE
		WHEN job_main.job_title LIKE '%Marketing Executive%' THEN 'Marketing Executive'
		ELSE job_main.job_title
		END AS job_title,
	job_main.currency,
	job_main.salary_min,
	job_main.salary_max
	FROM job_main
	JOIN job_type
	  ON job_main.scrapedid = job_type.scrapedid
	 WHERE 
		 job_main.job_title LIKE '%Marketing Executive%' 
	 AND job_main.year_experience_min  is not null 
	 AND job_main.year_experience_max is not null
	 And job_main.career_level is not null 
	 AND job_main.currency is not null 
	 AND job_main.salary_min is not null
	 AND job_main.salary_max is not null
)


SELECT type
	, currency
	, min(salary_min) as salary_min
	, max(salary_max) as salary_max
FROM BASE_SALARY_TYPE
group by type, currency


-- Range Salary based on career level and experience
WITH BASE_SALARY_CAREER_LEVEL
AS (
	SELECT
	job_main.scrapedid,
	CASE
		WHEN job_main.job_title LIKE '%Marketing Executive%' THEN 'Marketing Executive'
		ELSE job_main.job_title
		END AS job_title,
	job_main.career_level,
	job_main.currency,
	job_main.year_experience_min,
	job_main.year_experience_max,
	job_main.salary_min,
	job_main.salary_max
	FROM job_main
	 WHERE 
		 job_main.job_title LIKE '%Marketing Executive%' 
	 AND job_main.year_experience_min  is not null 
	 AND job_main.year_experience_max is not null
	 And job_main.career_level is not null 
	 AND job_main.currency is not null 
	 AND job_main.salary_min is not null
	 AND job_main.salary_max is not null
)


SELECT career_level
	, currency
	, year_experience_min
	, year_experience_max
	, min(salary_min) as salary_min
	, max(salary_max) as salary_max
FROM BASE_SALARY_CAREER_LEVEL
GROUP BY career_level, currency, year_experience_min, year_experience_max
ORDER BY career_level, year_experience_min


-- Create table responsibilities
CREATE TABLE responsibilities (
		"id" INTEGER NOT NULL,
		"responsibility" VARCHAR NOT NULL
	);


-- show responsibilities
SELECT *
FROM responsibilities


-- Searching marketing executive position that possible for gig job
SELECT
	job_main.scrapedid,
	job_location.location,
	job_category.category,
	job_type.type,
	job_main.job_title,
	job_main.career_level,
	job_main.year_experience_min,
	job_main.year_experience_max,
	job_main.currency,
	job_main.salary_min,
	job_main.salary_max,
	job_req_edu.requirement
FROM job_main
JOIN job_location
  ON job_main.scrapedid = job_location.scrapedid
JOIN job_category
  ON job_main.scrapedid = job_category.scrapedid
JOIN job_type
  ON job_main.scrapedid = job_type.scrapedid
JOIN job_req_edu
  ON job_main.scrapedid = job_req_edu.scrapedid
 WHERE 
     job_main.job_title LIKE '%Marketing Executive%' 
 AND job_type.type is NOT 'fulltime' 
 AND job_main.year_experience_min is not null 
 AND job_main.year_experience_max is not null 
 And job_main.career_level is not null
 AND job_main.currency is not null 
 AND job_main.salary_min is not null
 AND job_main.salary_max is not null;
 
 
 -- Searching List responsibilities and job desc for gig job
WITH BASE_RESPONSIBILITY
AS (
	SELECT *
		, CASE
			WHEN LOWER(responsibility) LIKE '%marketing%' THEN 'Y'
			WHEN LOWER(responsibility) LIKE '%market%' THEN 'Y'
			WHEN LOWER(responsibility) LIKE '%media%' THEN 'Y'
			WHEN LOWER(responsibility) LIKE '%social%' THEN 'Y'
			WHEN LOWER(responsibility) LIKE '%communication%' THEN 'Y'
			WHEN LOWER(responsibility) LIKE '%campaign%' THEN 'Y'
			WHEN LOWER(responsibility) LIKE '%relationship%' THEN 'Y'
			WHEN LOWER(responsibility) LIKE '%research%' THEN 'Y'
			WHEN LOWER(responsibility) LIKE '%engage%' THEN 'Y'
			WHEN LOWER(responsibility) LIKE '%customers%' THEN 'Y'
			WHEN LOWER(responsibility) LIKE '%awareness%' THEN 'Y'
			WHEN LOWER(responsibility) LIKE '%content%' THEN 'Y'
			WHEN LOWER(responsibility) LIKE '%sales%' THEN 'Y'
			WHEN LOWER(responsibility) LIKE '%diploma%' THEN 'Y'
			ELSE 'N'
			END AS FLAG_MARKETING_JOB
		, CASE
			WHEN LOWER(responsibility) LIKE '%intern%' THEN 'Y'
			WHEN LOWER(responsibility) LIKE '%trainee%' THEN 'Y'
			WHEN LOWER(responsibility) LIKE '%assist%' THEN 'Y'
			WHEN LOWER(responsibility) LIKE '%entry%' THEN 'Y'
			WHEN LOWER(responsibility) LIKE '%learning%' THEN 'Y'
			WHEN LOWER(responsibility) LIKE '%udpate%' THEN 'Y'
			WHEN LOWER(responsibility) LIKE '%contribute%' THEN 'Y'
			WHEN LOWER(responsibility) LIKE '%collaborate%' THEN 'Y'
			WHEN LOWER(responsibility) LIKE '%research%' THEN 'Y'
			WHEN LOWER(responsibility) LIKE '%analyze%' THEN 'Y'
			WHEN LOWER(responsibility) LIKE '%participate%' THEN 'Y'
			WHEN LOWER(responsibility) LIKE '%adapt%' THEN 'Y'
			WHEN LOWER(responsibility) LIKE '%support%' THEN 'Y'
			WHEN LOWER(responsibility) LIKE '%coordinate%' THEN 'Y'
			ELSE 'N'
			END AS FLAG_GIG_JOB
	FROM responsibilities
)

SELECT * FROM BASE_RESPONSIBILITY
WHERE FLAG_MARKETING_JOB = 'Y'
AND FLAG_GIG_JOB = 'Y'
