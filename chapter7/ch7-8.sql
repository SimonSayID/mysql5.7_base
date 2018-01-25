USE `cookbook`;

SELECT @total := SUM(miles) AS 'total miles' FROM driver_log;

SELECT name,
	SUM(miles) AS 'miles/driver',
	(SUM(miles)*100)/@total AS 'percent of total miles'
	FROM driver_log GROUP BY name;

SELECT name, AVG(miles) AS driver_avg FROM driver_log
	GROUP BY name HAVING driver_avg < (SELECT AVG(miles) FROM driver_log);

-- To display different summary-level values (and not perform 
-- calculations involving one summary level against another), 
-- add WITH ROLLUP to the GROUP BY clause

-- NULL in the name column represents the overall sum
SELECT name, SUM(miles) AS 'miles/driver' FROM driver_log
	GROUP BY name WITH ROLLUP;

-- NULL in the name column represents 
-- the average calculated over all drivers
SELECT name, AVG(miles) AS driver_avg FROM driver_log
	GROUP BY name WITH ROLLUP;

SELECT srcuser, dstuser, COUNT(*) FROM mail
	GROUP BY srcuser, dstuser;

-- Adding WITH ROLLUP causes the output to include an intermediate
-- count for each srcuser value (these are the lines with NULL in
-- the dstuser column), plus an overall count at the end
SELECT srcuser, dstuser, COUNT(*) FROM mail
	GROUP BY srcuser, dstuser WITH ROLLUP;