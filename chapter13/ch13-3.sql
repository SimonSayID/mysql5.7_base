USE `cookbook`;

-- Generating Frequency Distributions
SET @n = (SELECT COUNT(score) FROM testscore);
SELECT score, (COUNT(score)*100)/@n AS percent
	FROM testscore GROUP BY score;

-- lump values
SELECT FLOOR((score+1)/2)*2 AS `score rank`,
	COUNT(score) AS 'n' FROM testscore
	GROUP BY `score rank`; 

SELECT score, REPEAT('*', COUNT(score)) AS 'count histogram'
	FROM testscore GROUP BY score;

SELECT score, REPEAT('*', (COUNT(score)*100)/@n) 
	AS 'percent histogram'
	FROM testscore GROUP BY score;

CREATE TEMPORARY TABLE ref (score INT);
INSERT INTO ref (score)
	VALUES
		(0),(1),(2),(3),(4),(5),(6),(7),(8),(9),(10);

SELECT ref.score, COUNT(testscore.score) AS counts,
	REPEAT('*', COUNT(testscore.score)) AS 'count histogram'
	FROM ref LEFT JOIN testscore ON ref.score = testscore.score
	GROUP BY ref.score;

SELECT ref.score, (COUNT(testscore.score)*100)/@n AS percent,
	REPEAT('*', (COUNT(testscore.score)*100)/@n)
	AS 'percent histogram'
	FROM ref LEFT JOIN testscore ON ref.score = testscore.score
	GROUP BY ref.score;