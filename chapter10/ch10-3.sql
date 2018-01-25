USE `cookbook`;

DROP TABLE IF EXISTS null_table;

CREATE TABLE null_table
(
	c1		CHAR(20),
	c2 		INT,
	C3 		DATE
);

LOAD DATA LOCAL INFILE 'has_nulls.txt' 
	INTO TABLE null_table (@c1, @c2, @c3)
	SET c1 = IF(@c1='Unknown', NULL, @c1),
		c2 = IF(@c2=-1, NULL, @c2),
		c3 = IF(@c3='', NULL, @c3);
	
SELECT * FROM null_table;

DROP TABLE IF EXISTS null_table;

