USE `cookbook`;

-- Using a Join to Fill or Identify Holes in a List

SELECT trav_date, COUNT(trav_date) AS drivers
	FROM driver_log GROUP BY trav_date ORDER BY trav_date;

CREATE TEMPORARY TABLE tmp (d DATE);
INSERT INTO tmp (d)
	VALUES 
		('2014-07-26'),
		('2014-07-27'),
		('2014-07-28'),
		('2014-07-29'),
		('2014-07-30'),
		('2014-07-31'),
		('2014-08-01'),
		('2014-08-02');

SELECT tmp.d AS date, COUNT(driver_log.trav_date) AS drivers
	FROM tmp LEFT JOIN driver_log 
	ON tmp.d = driver_log.trav_date
	GROUP BY tmp.d ORDER BY tmp.d;

-- those dates on which no driver was active by looking for
-- reference rows for which no driver_log table rows have a
-- matching category valuev
SELECT tmp.d FROM tmp LEFT JOIN driver_log
	ON tmp.d = driver_log.trav_date
	WHERE driver_log.trav_date IS NULL;