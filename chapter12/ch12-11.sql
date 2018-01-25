USE `cookbook`;

-- Using a Join to Control Query Sort Order
CREATE TEMPORARY TABLE tmp 
	SELECT name, SUM(miles) AS driver_miles
	FROM driver_log GROUP BY name;

SELECT tmp.driver_miles, driver_log.*
	FROM driver_log JOIN tmp ON driver_log.name = tmp.name
	ORDER BY tmp.driver_miles DESC, driver_log.trav_date;

-- avoid using the temporary table
SELECT tmp.driver_miles, driver_log.*
	FROM driver_log JOIN 
	(SELECT name, SUM(miles) AS driver_miles
		FROM driver_log GROUP BY name) AS tmp
	ON driver_log.name = tmp.name
	ORDER BY tmp.driver_miles DESC, driver_log.trav_date;