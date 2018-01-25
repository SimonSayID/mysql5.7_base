USE `cookbook`;

SELECT d, DATE_SUB(d, INTERVAL DAYOFMONTH(d) -1 DAY) AS '1st of month'
	FROM date_val;

SELECT d,
	DATE_ADD(DATE_SUB(d, INTERVAL DAYOFMONTH(d) -1 DAY),
		INTERVAL -1 MONTH) AS '1st of  previous month',
	DATE_ADD(DATE_SUB(d, INTERVAL DAYOFMONTH(d) -1 DAY),
		INTERVAL 1 MONTH) AS '1st of following month'
	FROM date_val;

SELECT d,
	LAST_DAY(DATE_ADD(d, INTERVAL -1 MONTH))
		AS 'last of previous month',
	LAST_DAY(DATE_ADD(d, INTERVAL 1 MONTH))
		AS 'last of following month'
	FROM date_val;

SELECT d, DAYOFMONTH(LAST_DAY(d)) AS 'days in month' FROM date_val;