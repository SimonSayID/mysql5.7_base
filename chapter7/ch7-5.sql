USE `cookbook`;

-- Most aggregate functions ignore NULL values. COUNT() is different:
-- COUNT(expr) ignores NULL instances of expr , but COUNT(*) counts 
-- rows, regardless of content.
SELECT subject, test, score FROM expt ORDER BY subject, test;

SELECT subject,
	COUNT(score) AS n,
	SUM(score) AS total,
	AVG(score) AS average,
	MIN(score) AS lowest,
	MAX(score) AS highest
	FROM expt GROUP BY subject;

SELECT subject,
	COUNT(score) AS n,
	SUM(score) AS total,
	AVG(score) AS average,
	MIN(score) AS lowest,
	MAX(score) AS highest
	FROM expt WHERE score IS NULL GROUP BY subject;

SELECT subject,
	COUNT(score) AS n,
	IFNULL(SUM(score), 0) AS total,
	IFNULL(AVG(score), 0) AS average,
	IFNULL(MIN(score), 'Unknown') AS lowest,
	IFNULL(MAX(score), 'Unknown') AS highest
	FROM expt WHERE score IS NULL GROUP BY subject;

SELECT COUNT(*), COUNT(score) FROM expt;

SELECT COUNT(*) - COUNT(score) AS missing FROM expt;

SELECT subject,
	COUNT(*) AS total,
	COUNT(score) AS 'nonmissing',
	COUNT(*) - COUNT(score) AS 'missing'
	FROM expt GROUP BY subject;