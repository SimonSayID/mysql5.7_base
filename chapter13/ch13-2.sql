USE `cookbook`;

-- Calculating Descriptive Statistics

SELECT COUNT(score) AS n,
	SUM(score) AS sum,
	MIN(score) AS min,
	MAX(score) AS max,
	AVG(score) AS mean,
	STDDEV_SAMP(score) AS stddev_samp,
	VAR_SAMP(score) AS variance
	FROM testscore\G

-- The STDDEV_SAMP() and VAR_SAMP() functions produce sample
-- measures rather than population measures. That is, for 
-- a set of n values, they produce a result that is based on
-- n –1 degrees of freedom. For the population measures, 
-- which are based on n degrees of freedom, use STDDEV_POP() 
-- and VAR_POP() instead. STDDEV() and VARIANCE() are synonyms
-- for STDDEV_POP() and VAR_POP().

-- Per-Group Descriptive Statistics
SELECT age, COUNT(score) AS n,
	SUM(score) AS sum,
	MIN(score) AS min,
	MAX(score) AS max,
	AVG(score) AS mean,
	STDDEV_SAMP(score) AS stddev_samp,
	VAR_SAMP(score) AS variance
	FROM testscore GROUP BY age\G

SELECT sex, COUNT(score) AS n,
	SUM(score) AS sum,
	MIN(score) AS min,
	MAX(score) AS max,
	AVG(score) AS mean,
	STDDEV_SAMP(score) AS stddev_samp,
	VAR_SAMP(score) AS variance
	FROM testscore GROUP BY sex\G

SELECT age, sex, COUNT(score) AS n,
	SUM(score) AS sum,
	MIN(score) AS min,
	MAX(score) AS max,
	AVG(score) AS mean,
	STDDEV_SAMP(score) AS stddev_samp,
	VAR_SAMP(score) AS variance
	FROM testscore GROUP BY age, sex;

