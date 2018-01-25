USE `cookbook`;

-- The +1023 in the FLOOR() expression groups size values to the 
-- nearest upper boundary of the 1,024-byte categories. Without it,
-- the values group by lower boundaries (for example, a 2,047-byte 
-- message is reported as having a size of 1 kilobyte rather than 2).

SELECT t, srcuser, FLOOR((size+1023)/1024)
	FROM mail WHERE size > 50000
	ORDER BY FLOOR((size+1023)/1024);

SELECT t, srcuser, FLOOR((size+1023)/1024) AS kilobytes
	FROM mail WHERE size > 50000
	ORDER BY kilobytes;

SELECT t, srcuser, CONCAT(FLOOR((size+1023)/1024), 'K') AS size_in_K
	FROM mail WHERE size > 50000
	ORDER BY size_in_K;

SELECT t, srcuser,
	CONCAT(FLOOR((size+1023)/1024), 'K') AS size_in_K
	FROM mail WHERE size > 50000
	ORDER BY size;

DROP TABLE IF EXISTS roster;
CREATE TABLE roster
(
	name		CHAR(30),
	jersey_num	CHAR(3)
);

INSERT INTO roster (name, jersey_num)
	VALUES
		('Lynne', '29'),
		('Ella','0'),
    	('Elizabeth','100'),
    	('Nancy','00'),
    	('Jean','8'),
    	('Sherry','47')
;

SELECT name, jersey_num FROM roster ORDER BY jersey_num;

-- add zero to the jersey_num values to 
-- force a string-to-number conversion
SELECT name, jersey_num FROM roster ORDER BY jersey_num+0;

SELECT t, CONCAT(srcuser, '@', srchost) AS sender, size
	FROM mail WHERE size > 50000
	ORDER BY srchost, srcuser;

DROP TABLE IF EXISTS name;
CREATE TABLE name
(
	last_name		CHAR(20),
	first_name		CHAR(20)
);

INSERT INTO name (first_name, last_name)
	VALUES
		('Kevin', 'Brown'),
		('Vida','Blue'),
		('Pete','Gray'),
		('Devon','White'),
		('Rondell','White')
;

SELECT last_name, first_name FROM name
	ORDER BY last_name, first_name;

SELECT CONCAT(first_name, ' ', last_name) AS full_name
	FROM name ORDER BY last_name, first_name;

