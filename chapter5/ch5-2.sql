USE `cookbook`;

SELECT CURTIME(), CURTIME(1), CURTIME(2), CURTIME(6);

DROP TABLE IF EXISTS t;
CREATE TABLE t (d DATE);

INSERT INTO t (d) VALUES (STR_TO_DATE('May 13, 2007', '%M %d, %Y'));
SELECT d FROM t;

DROP TABLE t;

-- The DATE_FORMAT() function takes two arguments: a DATE , DATETIME , 
-- or TIMESTAMP value, and a string describing how to display the value.
SELECT d, DATE_FORMAT(d, '%M %d, %Y') FROM date_val;

-- %Y Four-digit year
-- %y Two-digit year
-- %M Complete month name
-- %b Month name, initial three letters
-- %m Two-digit month of year (01..12)
-- %c Month of year (1..12)
-- %d Two-digit day of month (01..31)
-- %e Day of month (1..31)
-- %W Weekday name (Sunday..Saturday)
-- %r 12-hour time with AM or PM suffix
-- %T 24-hour time
-- %H Two-digit hour
-- %i Two-digit minute
-- %s Two-digit second
-- %% Literal %
SELECT dt,
	DATE_FORMAT(dt, '%c/%e/%y %r') AS format1,
	DATE_FORMAT(dt, '%M %e, %Y %T') AS format2
	FROM datetime_val;

SELECT dt,
	TIME_FORMAT(dt, '%r') AS '12-hour time',
	TIME_FORMAT(dt, '%T') AS '24-hour time'
	FROM datetime_val;

DROP FUNCTION IF EXISTS time_ampm;
CREATE FUNCTION time_ampm (t TIME)
RETURNS VARCHAR(13)
DETERMINISTIC
RETURN CONCAT
	(
		LEFT(TIME_FORMAT(t, '%r'), 9),
		IF(TIME_TO_SEC(t) < 12*60*60, 'a.m.', 'p.m.')
	);

SELECT t1, time_ampm(t1) FROM time_val;