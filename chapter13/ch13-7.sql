USE `cookbook`;

-- Finding Cumulative Sums and Running Averages

DROP TABLE IF EXISTS rainfall;

CREATE TABLE rainfall
(
	date 	DATE NOT NULL,
	precip 	FLOAT(10, 2) NOT NULL,

	PRIMARY KEY (date)
);

INSERT INTO rainfall (date, precip)
	VALUES
		('2014-06-01', 1.5),
		('2014-06-02', 0),
		('2014-06-03', 0.5),
		('2014-06-04', 0),
		('2014-06-05', 1.0)
;

SELECT date, precip FROM rainfall ORDER BY date;

SELECT SUM(precip) FROM rainfall WHERE date <= '2014-06-03';

-- for detail explain
-- SELECT t1.date, t1.precip AS 'daily precip'
-- 	FROM rainfall AS t1 JOIN rainfall AS t2
-- 	ON t1.date >= t2.date;

-- SELECT t1.date, t2.precip AS 'daily precip'
-- 	FROM rainfall AS t1 JOIN rainfall AS t2
-- 	ON t1.date >= t2.date ORDER BY t1.date;

SELECT t1.date, t1.precip AS 'daily precip',
	SUM(t2.precip) AS 'cum. precip'
	FROM rainfall AS t1 JOIN rainfall AS t2
	ON t1.date >= t2.date
	GROUP BY t1.date;

SELECT t1.date, t1.precip AS 'daily precip',
	SUM(t2.precip) AS 'cum. precip',
	COUNT(t2.precip) AS 'days elapsed',
	AVG(t2.precip) AS 'avg. precip'
	FROM rainfall AS t1 JOIN rainfall AS t2
	ON t1.date >= t2.date 
	GROUP BY t1.date;

-- produce “holes” in the table
DELETE from rainfall WHERE precip = 0;

SELECT t1.date, t1.precip AS 'daily precip',
	SUM(t2.precip) AS 'cum. precip',
	DATEDIFF(MAX(t2.date), MIN(t2.date)) + 1 AS 'days elapsed',
	SUM(t2.precip) / (DATEDIFF(MAX(t2.date), MIN(t2.date)) + 1)
	AS 'avg. precip' FROM rainfall AS t1 JOIN rainfall AS t2
	ON t1.date >= t2.date GROUP BY t1.date;

DROP TABLE IF EXISTS marathon;

CREATE TABLE marathon
(
	stage 	INT UNSIGNED NOT NULL AUTO_INCREMENT,
	km 		INT UNSIGNED NOT NULL,
	t 		TIME NOT NULL,

	PRIMARY KEY (stage)
);

INSERT INTO marathon (km, t)
	VALUES
		(5,'00:15:00'),
		(7,'00:19:30'),
		(9,'00:29:20'),
		(5,'00:17:50')
;

SELECT t1.stage, t1.km, SUM(t2.km) AS 'cum. km'
	FROM marathon AS t1 JOIN marathon AS t2
	ON t1.stage >= t2.stage GROUP BY t1.stage;

SELECT t1.stage, t1.km, t1.t,
	SUM(t2.km) AS 'cum. km',
	SEC_TO_TIME(SUM(TIME_TO_SEC(t2.t))) AS 'cum. t',
	SUM(t2.km)/(SUM(TIME_TO_SEC(t2.t))/(60*60)) 'avg. km/hour'
	FROM marathon AS t1 JOIN marathon AS t2
	ON t1.stage >= t2.stage GROUP BY t1.stage;