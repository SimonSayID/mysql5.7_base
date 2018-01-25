USE `cookbook`;

DROP TABLE IF EXISTS hostname;
CREATE TABLE hostname
(
	name 	VARCHAR(64)
);

INSERT INTO hostname (name)
	VALUES
		('svn.php.net'),
		('dbi.perl.org'),
	    ('lists.mysql.com'),
	    ('mysql.com'),
	    ('jakarta.apache.org'),
	    ('www.kitebird.com')
;

SELECT * FROM hostname ORDER BY name;

SELECT name,
	SUBSTRING_INDEX(SUBSTRING_INDEX(name, '.', -3), '.', 1) AS leftmost,
	SUBSTRING_INDEX(SUBSTRING_INDEX(name, '.', -2), '.', 1) AS middle,
	SUBSTRING_INDEX(name, '.', -1) AS rightmost
	FROM hostname;

SELECT name,
	SUBSTRING_INDEX(SUBSTRING_INDEX(CONCAT('..', name), '.', -3), '.', 1)
	AS leftmost,
	SUBSTRING_INDEX(SUBSTRING_INDEX(CONCAT('.', name), '.', -2), '.', 1)
	AS middle,
	SUBSTRING_INDEX(name, '.', -1) AS rightmost
	FROM hostname;

SELECT name FROM hostname ORDER BY 
	SUBSTRING_INDEX(name, '.', 1),
	SUBSTRING_INDEX(SUBSTRING_INDEX(CONCAT('.', name), '.', -2), '.', 1),
	SUBSTRING_INDEX(SUBSTRING_INDEX(CONCAT('..', name), '.', -3), '.', 1);