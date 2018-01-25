USE `cookbook`;

DROP TABLE IF EXISTS str_val;
CREATE TABLE str_val
(
	ci_str		CHAR(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci,
	cs_str		CHAR(3) CHARACTER SET latin1 COLLATE latin1_general_cs,
	bin_str		BINARY(3)
);

INSERT INTO str_val (ci_str, cs_str, bin_str)
	VALUES
		('AAA', 'AAA', 'AAA'),
		('aaa', 'aaa', 'aaa'),
		('bbb', 'bbb', 'bbb'),
		('BBB', 'BBB', 'BBB')
;


SELECT ci_str FROM str_val ORDER BY ci_str;

SELECT cs_str FROM str_val ORDER BY cs_str;

SELECT bin_str FROM str_val ORDER BY bin_str;

SELECT ci_str FROM str_val ORDER BY ci_str COLLATE latin1_general_cs;

SELECT cs_str FROM str_val ORDER BY cs_str COLLATE latin1_swedish_ci;

-- sort using values that have been converted to the same lettercase,
-- which makes lettercase irrelevant
SELECT cs_str FROM str_val ORDER BY UPPER(cs_str);

SELECT bin_str FROM str_val ORDER BY CONVERT(bin_str USING latin1)
	COLLATE latin1_swedish_ci;

