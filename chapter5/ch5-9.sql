USE `cookbook`;

SET @t1 = '12:00:00', @t2 = '15:30:00';
SELECT ADDTIME(@t1, @t2);

SET @dt = '1984-03-01 12:00:00', @t = '12:00:00';
SELECT ADDTIME(@dt, @t);

SET @d = '1984-03-01', @t = '15:30:00';
SELECT TIMESTAMP(@d, @t);

SET @dt = '1984-03-01 12:00:00', @t = '12:00:00';
SELECT TIMESTAMP(@dt, @t);

SELECT CURDATE(), DATE_ADD(CURDATE(), INTERVAL 3 DAY);

SELECT CURDATE(), DATE_SUB(CURDATE(), INTERVAL 1 WEEK);

SELECT NOW(), DATE_ADD(NOW(), INTERVAL 60 HOUR);

SELECT NOW(), DATE_ADD(NOW(), INTERVAL '14:30' HOUR_MINUTE);

SELECT NOW(), DATE_ADD(NOW(), INTERVAL '3 4' DAY_HOUR);

SELECT CURDATE(), CURDATE() + INTERVAL 1 YEAR;

SELECT NOW(), NOW() - INTERVAL '1 12' DAY_HOUR;

SELECT t1,
	SEC_TO_TIME(TIME_TO_SEC(t1) + 7200) AS 't1 plus 2 hours'
	FROM time_val;

SELECT t1, t2,
	TIME_TO_SEC(t1) + TIME_TO_SEC(t2) 
		AS 't1 + t2 (in seconds)',
	SEC_TO_TIME(TIME_TO_SEC(t1) + TIME_TO_SEC(t2))
		AS 't1 + t2 (as TIME)'
	FROM time_val;

-- The permitted range of a TIME column is -838:59:59 to 838:59:59
-- (that is, -3020399 to 3020399 seconds).

SELECT t1, t2,
	MOD(TIME_TO_SEC(t1) + TIME_TO_SEC(t2), 86400)
		AS 't1 + t2 (in seconds)',
	SEC_TO_TIME(MOD(TIME_TO_SEC(t1) + TIME_TO_SEC(t2), 86400))
		AS 't1 + t2 (as TIME)'
	FROM time_val;

SET @d = '1980-01-01';
SELECT @d AS date,
	FROM_DAYS(TO_DAYS(@d) + 7) AS 'date + 1 week',
	FROM_DAYS(TO_DAYS(@d) - 7) AS 'date - 1 week';

SET @dt = '1980-01-01 09:00:00';
SELECT @dt AS datetime,
	FROM_UNIXTIME(UNIX_TIMESTAMP(@dt) + 3600) AS 'datetime + 1 hour',
	FROM_UNIXTIME(UNIX_TIMESTAMP(@dt) - 3600) AS 'datetime - 1 hour';