USE `cookbook`;

-- That is, HAVING operates on the already-selected-and-grouped set of 
-- rows, applying additional constraints based on aggregate function
-- results that aren’t known during the initial selection process.
SELECT COUNT(*) AS count, name FROM driver_log 
	GROUP BY name HAVING COUNT(*) > 3;

-- the days on which only one driver was active
SELECT trav_date, COUNT(trav_date) FROM driver_log
	GROUP BY trav_date HAVING COUNT(trav_date) = 1;

-- the days on which more than one driver was active
SELECT trav_date, COUNT(trav_date) FROM driver_log
	GROUP BY trav_date HAVING COUNT(trav_date) > 1;

-- find message sender/recipient pairs between whom only one message
-- was sent, look for combinations that occur only once in the mail table
SELECT srcuser, dstuser FROM mail
	GROUP BY srcuser, dstuser HAVING COUNT(*) = 1;

-- To find days of the year on which more than one state joined the
-- Union, group by statehood month and day, and then use HAVING and
-- COUNT() to find the nonunique combinations
SELECT 
	MONTHNAME(statehood) AS month,
	DAYOFMONTH(statehood) AS day,
	COUNT(*) AS count
	FROM states GROUP BY month, day HAVING count > 1;

-- The aliases in the output column list could have been written 
-- using string quoting
-- backticks there to avoid mixing alias quoting styles within
-- a given query
SELECT FLOOR((pop+4999999)/5000000)*5 AS `max population (millions)`,
	COUNT(*) AS `number of states`
	FROM states GROUP BY `max population (millions)`;

SELECT FLOOR(LOG10(pop)) AS `log10(population)`,
	COUNT(*) AS `number of states`
	FROM states GROUP BY `log10(population)`;

