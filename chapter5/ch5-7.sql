USE `cookbook`;

SELECT t1,
	TIME_TO_SEC(t1) AS 'TIME to seconds',
	SEC_TO_TIME(TIME_TO_SEC(t1)) AS 'TIME to seconds to TIME'
	FROM time_val;

SELECT d,
	TO_DAYS(d) AS 'DATE to days',
	FROM_DAYS(TO_DAYS(d)) AS 'DATE to days to DATE'
	FROM date_val;

SELECT dt,
	TO_DAYS(dt) AS 'date part in days',
	FROM_DAYS(TO_DAYS(dt)) AS 'date part as DATE'
	FROM datetime_val;

SELECT dt,
	UNIX_TIMESTAMP(dt) AS seconds,
	FROM_UNIXTIME(UNIX_TIMESTAMP(dt)) AS timestamp
	FROM datetime_val;

SET time_zone = '+00:00';
SELECT dt,
	UNIX_TIMESTAMP(dt) AS seconds,
	FROM_UNIXTIME(UNIX_TIMESTAMP(dt)) AS timestamp
	FROM datetime_val;

SELECT CURDATE(), UNIX_TIMESTAMP(CURDATE()),
	FROM_UNIXTIME(UNIX_TIMESTAMP(CURDATE()))\G