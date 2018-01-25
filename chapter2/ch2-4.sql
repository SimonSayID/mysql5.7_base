USE `cookbook`;

SELECT * FROM expt WHERE score = NULL;

SELECT * FROM expt WHERE score <> NULL;

SELECT * FROM expt WHERE score IS NULL;

SELECT * FROM expt WHERE score IS NOT NULL;

SELECT NULL = NULL, NULL <=> NULL, NULL <=> "NULL", "NULL" <=> "NULL";

SELECT subject, test,
	IF(score IS NULL, 'Unknown', score) AS 'score'
	FROM expt;

-- same as IF(expr1 IS NOT NULL, expr1, expr2)
SELECT subject, test, IFNULL(score, 'Unknown') AS 'score'
FROM expt;

