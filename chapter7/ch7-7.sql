USE `cookbook`;

SELECT name, SUM(miles) FROM driver_log GROUP BY name;

SELECT name, SUM(miles) FROM driver_log
	GROUP BY name ORDER BY SUM(miles) DESC LIMIT 1;

SELECT LEFT(name, 1) AS letter, COUNT(*) FROM states
	GROUP BY letter ORDER BY COUNT(*) DESC LIMIT 1;

SET @max = (SELECT COUNT(*) FROM states GROUP BY
	LEFT(name, 1) ORDER BY COUNT(*) DESC LIMIT 1);
SELECT LEFT(name, 1) AS letter, COUNT(*) FROM states
	GROUP BY letter HAVING COUNT(*) = @max;

SELECT LEFT(name, 1) AS letter, COUNT(*) FROM states
	GROUP BY letter HAVING COUNT(*) = 
	(SELECT COUNT(*) FROM states GROUP BY LEFT(name, 1)
	ORDER BY COUNT(*) DESC LIMIT 1);

-- determine how many drivers were on the road and how many miles
-- were driven each day
SELECT trav_date, 
	COUNT(*) AS 'number of driver', 
	SUM(miles) AS 'miles logged'
	FROM driver_log GROUP BY trav_date;

SELECT YEAR(trav_date) AS year, MONTH(trav_date) AS month,
	COUNT(*) AS 'number of drivers', SUM(miles) AS 'miles logged'
	FROM driver_log GROUP BY year, month;

