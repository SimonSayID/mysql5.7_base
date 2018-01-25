USE `cookbook`;

-- For MID() , the second argument is the starting position of the 
-- substring you want (beginning from 1), and the third argument indicates
-- how many characters to return

SET @date = '2015-07-21';
SELECT @date, 
	LEFT(@date, 4) AS year, 
	MID(@date, 6, 2) AS month, 
	RIGHT(@date, 2) AS day
;

-- The SUBSTRING() function takes a string and a starting position, 
-- returning everything to the right of the position. MID() acts 
-- the same way if you omit its third argument because MID() is 
-- actually a synonym for SUBSTRING()

SELECT @date, SUBSTRING(@date, 6), MID(@date, 6);

SET @email = 'postmaster@example.com';
SELECT @email,
	SUBSTRING_INDEX(@email, '@', 1) AS user,
	SUBSTRING_INDEX(@email, '@', -1) AS host
;

SELECT name FROM metal WHERE LEFT(name, 1) >= 'n';

SELECT CONCAT(name, ' ends in "d": ', 
	IF(RIGHT(name, 1)='d', 'YES', 'NO')) AS 'ends in "d"?'
	FROM metal;

UPDATE metal SET name = CONCAT(name, 'ide');
SELECT name FROM metal;

UPDATE metal SET name = LEFT(name, CHAR_LENGTH(name)-3);
SELECT name FROM metal;

SELECT name, LOCATE('in', name), LOCATE('in', name, 3) FROM metal;

SELECT name, name LIKE '%in%', name REGEXP 'in' FROM metal;