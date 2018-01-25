USE `cookbook`;

-- Counting Missing Values

SELECT * FROM expt ORDER BY subject;

SELECT COUNT(*) AS 'n (total)',
	COUNT(score) AS 'n (nonmissing)',
	COUNT(*) - COUNT(score) AS 'n (missing)',
	((COUNT(*) - COUNT(score)) * 100 ) / COUNT(*) 
	AS '% missing' FROM expt;

-- other way
SELECT COUNT(*) AS 'n (total)',
	COUNT(score) AS 'n (nonmissing)',
	SUM(ISNULL(score)) AS 'n (missing)',
	(SUM(ISNULL(score)) * 100) / COUNT(*) AS '% missing'
	FROM expt;

SELECT subject, COUNT(*) AS 'n (total)',
	COUNT(score) AS 'n (nonmissing)',
	COUNT(*) - COUNT(score) AS 'n (missing)',
	((COUNT(*) - COUNT(score)) * 100 ) / COUNT(*) 
	AS '% missing' FROM expt GROUP BY subject;

-- Calculating Linear Regressions or 
-- Correlation Coefficients

-- least-squares regression
-- Y = bX + a
-- Letting age be X and score be Y , begin by computing 
-- the terms needed for the regression equation
SELECT
	@n := COUNT(score) AS N,
	@meanX := AVG(age) AS 'X mean',
	@sumX := SUM(age) AS 'X sum',
	@sumXX := SUM(age * age) AS 'X sum of squares',
	@meanY := AVG(score) AS 'Y mean',
	@sumY := SUM(score) AS 'Y sum',
	@sumYY := SUM(score * score) AS 'Y sum of squares',
	@sumXY := SUM(age * score) AS 'X * Y sum'
	FROM testscore\G;

SET @b := (@n * @sumXY - @sumX * @sumY) / 
			(@n * @sumXX - @sumX * @sumX);
SET @a := (@meanY - @b * @meanX);
SELECT @b AS slope, @a AS intercept;

SELECT CONCAT('Y = ', @b, 'X + ', @a) 
	AS 'least-squares regression';

SELECT (@n*@sumXY - @sumX*@sumY) /
		SQRT(
				(@n*@sumXX - @sumX*@sumX) * 
				(@n*@sumYY - @sumY*@sumY)
			) AS correlation;