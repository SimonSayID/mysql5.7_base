USE `cookbook`;

DROP VIEW IF EXISTS trip_summary_view;
CREATE VIEW trip_summary_view AS
	SELECT 
		COUNT(IF(DAYOFWEEK(trav_date) IN (1, 7), 1, NULL))
			AS weekend_trips,
		COUNT(IF(DAYOFWEEK(trav_date) IN (1, 7), NULL, 1))
			AS weekday_trips
	FROM driver_log;

SELECT * FROM trip_summary_view;

SELECT MAX(pop) FROM states;

-- Aggregate functions such as MIN() and MAX() cannot be used in WHERE
-- clauses, which require expressions that apply to individual rows
SET @max = (SELECT MAX(pop) FROM states);
SELECT pop AS 'highest population', name FROM states WHERE pop = @max;

SELECT pop AS 'highest population', name FROM states
	WHERE pop = (SELECT MAX(pop) FROM states);

SELECT MIN(CHAR_LENGTH(vtext)) FROM kjv;

SELECT bname, cnum, vnum, vtext FROM kjv
	WHERE CHAR_LENGTH(vtext) = (SELECT MIN(CHAR_LENGTH(vtext)) FROM kjv);

CREATE TEMPORARY TABLE tmp SELECT MAX(pop) as maxpop FROM states;

SELECT states.* FROM states JOIN tmp ON states.pop = tmp.maxpop;

-- • To compare case-insensitive strings in case-sensitive fashion, order
-- the values using a case-sensitive collation:
-- SELECT
-- 	MIN(str_col COLLATE latin1_general_cs) AS min,
-- 	MAX(str_col COLLATE latin1_general_cs) AS max
-- FROM tbl;
-- • To compare case-sensitive strings in case-insensitive fashion, order
-- the values using a case-insensitive collation:
-- SELECT
-- 	MIN(str_col COLLATE latin1_swedish_ci) AS min,
-- 	MAX(str_col COLLATE latin1_swedish_ci) AS max
-- FROM tbl;
-- Another possibility is to compare values that have all been converted 
-- to the same lettercase, which makes lettercase irrelevant. However, 
-- that also changes the retrieved values:
-- SELECT
-- 	MIN(UPPER(str_col)) AS min,
-- 	MAX(UPPER(str_col)) AS max
-- FROM tbl;
-- • Binary strings compare using numeric byte values, so there is no 
-- concept of lettercase involved. However, because letters in different 
-- cases have different byte values, comparisons of binary strings 
-- effectively are case sensitive. (That is, a and A are unequal.) To 
-- compare binary strings using a case-insensitive ordering, convert them
-- to nonbinary strings and apply an appropriate collation:
-- SELECT
-- 	MIN(CONVERT(str_col USING latin1) COLLATE latin1_swedish_ci) AS min,
-- 	MAX(CONVERT(str_col USING latin1) COLLATE latin1_swedish_ci) AS max
-- FROM tbl;
-- If the default collation is case insensitive (as is true for latin1 ),
-- you can omit the COLLATE clause.