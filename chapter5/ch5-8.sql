USE `cookbook`;

SET @d1 = '2010-01-01', @d2 = '2009-12-01';
SELECT DATEDIFF(@d1, @d2) AS 'd1 - d2', 
		DATEDIFF(@d2, @d1) AS 'd2 - d1';

SET @t1 = '12:00:00', @t2 = '16:30:00';
SELECT TIMEDIFF(@t1, @t2) AS 't1 - t2', TIMEDIFF(@t2, @t1) AS 't2 -t1';

SELECT t1, t2,
	TIMEDIFF(t2, t1) AS 't2 - t1 as TIME',
	IF(TIMEDIFF(t2, t1) >= 0, '+', '-') AS sign,
	HOUR(TIMEDIFF(t2, t1)) AS hour,
	MINUTE(TIMEDIFF(t2, t1)) AS minute,
	SECOND(TIMEDIFF(t2, t1)) AS second
	FROM time_val;

-- Its value is negative if the first temporal value is greater than 
-- the second, which is opposite the order of the arguments for
-- DATEDIFF() and TIMEDIFF()
-- Despite the TIMESTAMP in its name, TIMESTAMPDIFF() arguments are 
-- not limited to the range of the TIMESTAMP data type.

SET @dt1 = '1900-01-01 00:00:00', @dt2 = '1910-01-01 00:00:00';
SELECT 
	TIMESTAMPDIFF(MINUTE, @dt1, @dt2) AS minute,
	TIMESTAMPDIFF(HOUR, @dt1, @dt2) AS hour,
	TIMESTAMPDIFF(DAY, @dt1, @dt2) AS day,
	TIMESTAMPDIFF(WEEK, @dt1, @dt2) AS weeks,
	TIMESTAMPDIFF(YEAR, @dt1, @dt2) AS years;

SELECT t1, t2,
	TIME_TO_SEC(t2) - TIME_TO_SEC(t1) AS 't2 - t1 (in seconds)',
	SEC_TO_TIME(TIME_TO_SEC(t2) - TIME_TO_SEC(t1)) AS 't2 - t1 (as TIME)'
	FROM time_val;

SET @days = TO_DAYS('1884-01-01') - TO_DAYS('1883-06-05');
SELECT @days AS days, @days/7 AS weeks;

SET @dt1 = '1984-01-01 09:00:00';
SET @dt2 = @dt1 + INTERVAL 14 DAY;
SET @interval = UNIX_TIMESTAMP(@dt2) - UNIX_TIMESTAMP(@dt1);
SELECT @interval AS seconds,
	@interval / 60 AS minutes,
	@interval / (60 * 60) AS hours,
	@interval / (24 * 60 *60) AS days,
	@interval / (7 * 24 * 60 * 60) AS weeks;

SET @dt1 = '1800-02-14 07:30:00';
SET @dt2 = '1800-02-17 06:30:00';
SET @interval = ((TO_DAYS(@dt2) - TO_DAYS(@dt1)) * 24 * 60 *60)
	+ TIME_TO_SEC(@dt2) - TIME_TO_SEC(@dt1);
SELECT @interval AS seconds, SEC_TO_TIME(@interval) AS TIME;