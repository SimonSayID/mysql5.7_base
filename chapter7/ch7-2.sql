USE `cookbook`;

-- Tips: COUNT(expr) doesn’t count NULL values

SELECT COUNT(*) FROM driver_log;

SELECT COUNT(*) FROM states;

-- How many times did drivers travel more than 200 miles in a day?
SELECT COUNT(*) FROM driver_log WHERE miles > 200;

-- How many days did Suzi drive?
SELECT COUNT(*) FROM driver_log WHERE name = 'Suzi';

-- How many of the United States joined the Union in the 19th century?
SELECT COUNT(*) FROM states WHERE statehood 
	BETWEEN '1800-01-01' AND '1899-12-31';

-- count the number of Saturday and Sunday trips 
-- in the driver_log table
SELECT 
	COUNT(IF(DAYOFWEEK(trav_date)=7,1,NULL)) AS 'Saturday trips',
	COUNT(IF(DAYOFWEEK(trav_date)=1,1,NULL)) AS 'Sunday trips'
	FROM driver_log;

-- count weekend versus weekday trips
SELECT
	COUNT(IF(DAYOFWEEK(trav_date) IN (1, 7), 1, NULL)) 
		AS 'weekend trips',
	COUNT(IF(DAYOFWEEK(trav_date) IN (1, 7), NULL, 1))
		AS 'weekday trips'
	FROM driver_log;

SELECT 
	MIN(t) AS earliest, MAX(t) AS latest,
	MIN(size) AS smallest, MAX(size) AS largest
	FROM mail;

-- What are the smallest and largest US state populations?
SELECT 
	MIN(pop) AS 'fewest people', MAX(pop) AS 'most people'
	FROM states;

-- What are the first and last state names, lexically speaking?
-- The shortest and longest names?
SELECT
	MIN(name) AS first,
	MAX(name) AS last,
	MIN(CHAR_LENGTH(name)) AS shortest,
	MAX(CHAR_LENGTH(name)) AS longest
	FROM states;

-- Tips: SUM() and AVG() are numeric functions, so they can’t 
-- be used with strings or temporal values

-- What is the total amount of mail traffic
-- in bytes and the average size of each message?
SELECT 
	SUM(size) AS 'total traffic',
	AVG(size) AS 'average message size'
	FROM mail;

-- How many miles did the drivers in the driver_log table travel?
-- What was the average number of miles traveled per day?
SELECT
	SUM(miles) AS 'total miles',
	AVG(miles) AS 'average miles/day'
	FROM driver_log;

-- What is the total population of the United States?
SELECT SUM(pop) FROM states;

SELECT t1 FROM time_val;

SELECT 
	SUM(TIME_TO_SEC(t1)) AS 'total seconds',
	SEC_TO_TIME(SUM(TIME_TO_SEC(t1))) AS 'total time'
	FROM time_val;

SELECT DISTINCT name FROM driver_log ORDER BY name;

-- Tips: COUNT(DISTINCT) ignores NULL values.
-- To count NULL as one of the values in the set if
-- it’s present, use one of the following expressions:
-- COUNT(DISTINCT val) + IF(COUNT(IF(val IS NULL,1,NULL))=0,0,1)
-- COUNT(DISTINCT val) + IF(SUM(ISNULL(val))=0,0,1)
-- COUNT(DISTINCT val) + (SUM(ISNULL(val))<>0)
-- To determine the number of different drivers
SELECT COUNT(DISTINCT name) FROM driver_log;

SELECT COUNT(DISTINCT srcuser, dstuser) FROM mail;