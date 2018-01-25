USE `cookbook`;

SELECT d,
	YEAR(d) % 4 = 0 
		AS 'rule of thumb test',
	(YEAR(d) % 4 = 0) AND ((YEAR(d) % 100 <> 0) OR (YEAR(d) % 400 = 0))
		AS 'complete test'
	FROM date_val;

SET @d1 = '2014-04-13', @d2 = '2016-04-13';
SELECT DAYOFYEAR(DATE_FORMAT(@d1, '%Y-12-31')) AS 'days in 2014',
		DAYOFYEAR(DATE_FORMAT(@d2, '%Y-12-31')) AS 'days in 2016';

SELECT 
	CONCAT(YEAR(d), '-', MONTH(d), '-01') 
		AS 'non-ISO',
	DATE_ADD(CONCAT(YEAR(d), '-', MONTH(d), '-01'), INTERVAL 0 DAY) 
		AS 'ISO 1',
	CONCAT(YEAR(d), '-', MONTH(d), '-01') + INTERVAL 0 DAY 
		AS 'ISO 2',
	FROM_DAYS(TO_DAYS(CONCAT(YEAR(d), '-', MONTH(d), '-01'))) 
		AS 'ISO 3',
	STR_TO_DATE(CONCAT(YEAR(d), '-', MONTH(d), '-01'), '%Y-%m-%d') 
		AS 'ISO 4'
	FROM date_val;

SELECT d FROM date_val;

SELECT d FROM date_val WHERE d < '1900-01-01';

SELECT d FROM date_val WHERE d BETWEEN '1900-01-01' AND '1999-12-31';

SELECT d FROM date_val WHERE d >= DATE_SUB(CURDATE(), INTERVAL 20 YEAR);