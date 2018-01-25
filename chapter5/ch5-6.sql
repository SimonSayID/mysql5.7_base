USE `cookbook`;

SELECT MAKETIME(10,30,58), MAKETIME(-5,0,11);

SELECT d, DATE_FORMAT(d, '%Y-%m-01') FROM date_val;

SELECT t1, TIME_FORMAT(t1, '%H:%i:00') FROM time_val;

SELECT d, CONCAT(YEAR(d), '-', MONTH(d), '-1') FROM date_val;

-- LPAD()
-- Return the string argument, left-padded with the specified string 

SELECT d, CONCAT(YEAR(d), '-', LPAD(MONTH(d), 2, '0'), '-01')
	FROM date_val;

-- SELECT t1, CONCAT(LPAD(HOUR(t1), 2 '0'), ':', 
-- 					LPAD(MINUTE(t1), 2, '0'), ':00')
-- 	AS recombined FROM time_val;

SELECT t1, CONCAT(
	LPAD(HOUR(t1), 2, '0'), ':',
	LPAD(MINUTE(t1), 2, '0'), ':00') AS recombined
		FROM time_val;

SET @d = '2014-02-28', @t = '13:10:05';
SELECT @d, @t, CONCAT(@d, ' ', @t);