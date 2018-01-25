USE  `cookbook`;

SELECT d,
	DATE_FORMAT(d, '%Y-%m-01') AS '1st of month A',
	CONCAT(YEAR(d), '-', LPAD(MONTH(d), 2, '0'), '-01') 
		AS '1st of month B'
	FROM date_val;

SELECT d,
	DATE_FORMAT(d, '%Y-01-01') AS 'New Year''s A',
	CONCAT(YEAR(d), '-01-01') AS 'New Year''s B',
	DATE_FORMAT(d, '%Y-12-25') AS 'Christmas A',
	CONCAT(YEAR(d), '-12-25') AS 'Christmas B'
	FROM date_val;

SELECT CURDATE(),
	DATE_ADD(DATE_FORMAT(CURDATE(), '%Y-12-25'), INTERVAL 2 YEAR)
		AS 'Christmas A',
	DATE_FORMAT(DATE_ADD(CURDATE(), INTERVAL 2 YEAR), '%Y-12-25')
		AS 'Christmas B';

SELECT CURDATE(), DAYNAME(CURDATE());

SET @d = CURDATE();
SET @first = DATE_SUB(@d, INTERVAL DAYOFMONTH(@d) -1 DAY);
SELECT @d AS 'starting date',
	@first AS '1st of month date',
	DAYNAME(@first) AS '1st of month day';

-- DAYOFWEEK() treats Sunday as the first day of the week and
-- returns 1 through 7 for Sunday through Saturday. 
-- WEEKDAY() treats Monday as the first day of the week and 
-- returns 0 through 6 for Monday through Sunday

SELECT d, DAYNAME(d) AS 'day',
	DAYOFWEEK(d) AS 'DAYOFWEEK',
	DATE_ADD(d, INTERVAL 1-DAYOFWEEK(d) DAY) AS 'sunday',
	DATE_ADD(d, INTERVAL 7-DAYOFWEEK(d) DAY) AS 'saturday'
	FROM date_val;

SET @target = DATE_SUB(
	DATE_ADD(CURDATE(), INTERVAL 4-DAYOFWEEK(CURDATE()) DAY),
	INTERVAL 14 DAY);
SELECT CURDATE(), @target, DAYNAME(@target);

SET @target = DATE_ADD(DATE_SUB(CURDATE(), INTERVAL 14 DAY),
	INTERVAL 4-DAYOFWEEK(CURDATE()) DAY);
SELECT CURDATE(), @target, DAYNAME(@target);