USE `cookbook`;

DROP TABLE IF EXISTS housewares;
CREATE TABLE housewares
(
	id				VARCHAR(20),
	description		VARCHAR(255)
);

INSERT INTO housewares (id, description)
	VALUES
		('DIN40672US', 'dining table'),
		('KIT00372UK', 'garbage disposal'),
		('KIT01729JP', 'microwave oven'),
		('BED00038SG', 'bedside lamp'),
		('BTH00485US', 'shower stall'),
		('BTH00415JP', 'lavatory')
;

SELECT * FROM housewares ORDER BY id;

SELECT id,
	LEFT(id, 3) AS category,
	MID(id, 4, 5) AS serial,
	RIGHT(id, 2) AS country
	FROM housewares;

SELECT * FROM housewares ORDER BY LEFT(id, 3);

SELECT * FROM housewares ORDER BY MID(id, 4, 5);

SELECT * FROM housewares ORDER BY RIGHT(id, 2), MID(id, 4, 5);

DROP TABLE IF EXISTS housewares3;
CREATE TABLE housewares3
(
	id				VARCHAR(20),
	description		VARCHAR(255)
);

INSERT INTO housewares3 (id, description)
	VALUES
		('DIN40672US', 'dining table'),
		('KIT372UK', 'garbage disposal'),
	    ('KIT1729JP', 'microwave oven'),
	    ('BED38SG', 'bedside lamp'),
	    ('BTH485US', 'shower stall'),
	    ('BTH415JP', 'lavatory')
;

SELECT id, LEFT(SUBSTRING(id, 4), CHAR_LENGTH(SUBSTRING(id, 4)-2))
	FROM housewares3;

SELECT id, SUBSTRING(id, 4), SUBSTRING(id, 4, CHAR_LENGTH(id)-5)
	FROM housewares3;

SELECT * FROM housewares3 ORDER BY SUBSTRING(id, 4, CHAR_LENGTH(id)-5);

SELECT * FROM housewares3 ORDER BY SUBSTRING(id, 4, CHAR_LENGTH(id)-5)+0;

-- In this particular case, a simpler solution is possible. It’s 
-- unnecessary to calculate the length of the numeric part of the string,
-- because a string-to-number conversion operation strips trailing 
-- nonnumeric suffixes and provides the values needed to sort on the 
-- variable-length serial number portion of the id values. That means 
-- the third argument to SUBSTRING() actually isn’t needed
SELECT * FROM housewares3 ORDER BY SUBSTRING(id, 4)+0;

DROP TABLE IF EXISTS housewares4;
CREATE TABLE housewares4
(
	id      	VARCHAR(20),
  	description VARCHAR(255)
);

INSERT INTO housewares4 (id, description)
	VALUES
		('13-478-92-2', 'dining table'),
	    ('873-48-649-63', 'garbage disposal'),
	    ('8-4-2-1', 'microwave oven'),
	    ('97-681-37-66', 'bedside lamp'),
	    ('27-48-534-2', 'shower stall'),
	    ('5764-56-89-72', 'lavatory')
;

SELECT id,
	SUBSTRING_INDEX(SUBSTRING_INDEX(id, '-', 2), '-', -1) AS segment2,
	SUBSTRING_INDEX(SUBSTRING_INDEX(id, '-', 4), '-', -1) AS segment4
	FROM housewares4;

-- lexical sort
SELECT * FROM housewares4 
	ORDER BY SUBSTRING_INDEX(
				SUBSTRING_INDEX(id, '-', 2), '-', -1);
-- numerically
SELECT * FROM housewares4
	ORDER BY SUBSTRING_INDEX(
				SUBSTRING_INDEX(id, '-', 2), '-', -1)+0;
