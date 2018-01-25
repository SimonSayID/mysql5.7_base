USE `cookbook`;

-- YEAR() Year of date
-- MONTH() Month number (1..12)
-- MONTHNAME() Month name (January..December)
-- DAYOFMONTH() Day of month (1..31)
-- DAYNAME() Day name (Sunday..Saturday)
-- DAYOFWEEK() Day of week (1..7 for Sunday..Saturday)
-- WEEKDAY() Day of week (0..6 for Monday..Sunday)
-- DAYOFYEAR() Day of year (1..366)
-- HOUR() Hour of time (0..23)
-- MINUTE() Minute of time (0..59)
-- SECOND() Second of time (0..59)
-- EXTRACT() Varies

SELECT dt, DATE(dt), TIME(dt) FROM datetime_val;

SELECT dt, YEAR(dt), DAYOFMONTH(dt), HOUR(dt), SECOND(dt) 
	FROM datetime_val;

SELECT d, DAYNAME(d), LEFT(DAYNAME(d), 3) FROM date_val;

-- DAYOFWEEK() returns values from 1 to 7, corresponding to
-- Sunday through Saturday. 
-- WEEKDAY() returns values from 0 to 6, corresponding to
-- Monday through Sunday

SELECT d, DAYNAME(d), DAYOFWEEK(d), WEEKDAY(d) FROM date_val;

SELECT dt, EXTRACT(DAY FROM dt), EXTRACT(HOUR FROM dt)
	FROM datetime_val;

SET @d = CURDATE();
SELECT @d, YEAR(@d) AS year, MONTH(@d) AS month, 
	MONTHNAME(@d) AS monthname, DAYOFMONTH(@d) AS day, 
	DAYNAME(@d) AS dayname
;

SET @n = NOW();
SELECT NOW(), HOUR(@n) AS hour, MINUTE(@n) AS minute,
	SECOND(@n) AS second;

SELECT dt,
	DATE_FORMAT(dt, '%Y') AS year,
	DATE_FORMAT(dt, '%d') AS day,
	DATE_FORMAT(dt, '%H') AS hour,
	DATE_FORMAT(dt, '%s') AS second
	FROM datetime_val;

SELECT dt,
	DATE_FORMAT(dt, '%Y-%m-%d') AS 'date part',
	TIME_FORMAT(dt, '%T') AS 'time part'
	FROM datetime_val;

SELECT dt,
	DATE_FORMAT(dt, '%M %e, %Y') AS 'decriptive date',
	TIME_FORMAT(dt, '%H:%i') AS 'hour/minutes'
	FROM datetime_val;