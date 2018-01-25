USE `cookbook`;

SELECT thing, UPPER(thing), LOWER(thing) FROM limbs;

-- binary strings that have no character set or collation. 
-- Lettercase does not apply, and UPPER() and LOWER() do nothing

DROP TABLE IF EXISTS t;
CREATE TABLE t (b BLOB) SELECT 'aBcD' AS b;
SELECT b, UPPER(b), LOWER(b) FROM t;

SELECT b,
	UPPER(CONVERT(b USING latin1)) AS upper,
	LOWER(CONVERT(b USING latin1)) AS lower
	FROM t;

DROP TABLE t;

DROP FUNCTION IF EXISTS initial_cap;
CREATE FUNCTION initial_cap (s VARCHAR(255))
RETURNS VARCHAR(255) DETERMINISTIC
RETURN CONCAT(UPPER(LEFT(s,1)), MID(s, 2));

SELECT thing, initial_cap(thing) FROM limbs;