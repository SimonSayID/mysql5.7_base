USE `cookbook`;

SELECT t, srcuser, dstuser, size FROM mail
	ORDER BY IF(srcuser='phil', 0, 1), srcuser, dstuser;

SELECT t, srcuser, dstuser, size FROM mail
	ORDER BY IF(srcuser=dstuser, 0, 1), srcuser, dstuser;

-- Custom Sort Order
SELECT * FROM driver_log ORDER BY
	FIELD(name, 'Henry', 'Suzi', 'Ben');

DROP TABLE IF EXISTS weekday;
CREATE TABLE weekday
(
	day ENUM('Sunday', 'Monday', 'Tuesday', 'Wednesday',
				'Thursday', 'Friday', 'Saturday')
);

INSERT INTO weekday (day)
	VALUES
		('Monday'),
		('Friday'),
		('Tuesday'),
		('Sunday'),
		('Thursday'),
		('Saturday'),
		('Wednesday')
;

SELECT day, day+0 FROM weekday;

SELECT day, day+0 FROM weekday ORDER BY day;

-- lexical order
SELECT day, day+0 FROM weekday ORDER BY CAST(day AS CHAR);

DROP TABLE IF EXISTS color;
CREATE TABLE color
(
	name 	CHAR(10)
);

INSERT INTO color (name)
	VALUES
		('blue'),
		('green'),
		('indigo'),
		('orange'),
		('red'),
		('violet'),
		('yellow')
;

-- lexical order
SELECT name FROM color ORDER BY name;

-- “Roy G. Biv” order
SELECT name FROM color ORDER BY
	FIELD(name, 'red', 'orange', 'yellow', 'green', 
				'blue', 'indigo', 'violet');

-- To accomplish the same end without FIELD() , use ALTER TABLE 
-- to convert the name column to an ENUM that lists the colors in
-- the desired sort order
ALTER TABLE color MODIFY name
	ENUM('red', 'orange', 'yellow', 'green',
			'blue', 'indigo', 'violet');

SELECT name FROM color ORDER BY name;