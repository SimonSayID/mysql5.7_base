USE `cookbook`;

-- default FIELDS TERMINATED is \t (Tab)

DROP TABLE IF EXISTS mytbl1;

CREATE TABLE mytbl1
(
	c1	CHAR(20),
	c2 	CHAR(20)
);

LOAD DATA LOCAL INFILE 'mytbl.txt' INTO TABLE mytbl1;

SELECT * FROM mytbl1;

DROP TABLE IF EXISTS mytbl1;

SHOW WARNINGS;

-- ########################################

DROP TABLE IF EXISTS mytbl2;

CREATE TABLE mytbl2
(
	c1	CHAR(20),
	c2 	CHAR(20)
);

LOAD DATA LOCAL INFILE 'mytbl.txt' INTO TABLE mytbl2
	FIELDS TERMINATED BY ':' LINES TERMINATED BY '\r';

SELECT * FROM mytbl2;

DROP TABLE IF EXISTS mytbl2;

SHOW WARNINGS;

-- ########################################

DROP TABLE IF EXISTS mytbl2;

CREATE TABLE mytbl2
(
	c1	CHAR(20),
	c2 	CHAR(20)
);

LOAD DATA LOCAL INFILE 'mytbl-csv.txt' INTO TABLE mytbl2
	FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';

SELECT * FROM mytbl2;

DROP TABLE IF EXISTS mytbl2;

SHOW WARNINGS;

-- ########################################

DROP TABLE IF EXISTS test_data;

CREATE TABLE test_data
(
	i 	INT,
	c 	CHAR(3),
	d 	DATE
);

LOAD DATA LOCAL INFILE 'field.txt' INTO TABLE test_data;

SHOW WARNINGS;

SELECT * FROM test_data;

DROP TABLE IF EXISTS test_data;

-- ########################################

DROP TABLE IF EXISTS people_data;

CREATE TABLE people_data
(
	dt DATETIME,
	last_name CHAR(10),
	first_name CHAR(10),
	weight_kg FLOAT,
	st_abbrev CHAR(2)
);

LOAD DATA LOCAL INFILE 'people.txt' INTO TABLE people_data
	IGNORE 1 LINES
	(@date, @time, @name, @weight_lb, @state)
	SET dt = CONCAT(@date, ' ', @time),
		first_name = SUBSTRING_INDEX(@name, ' ', 1),
		last_name = SUBSTRING_INDEX(@name, ' ', -1),
		weight_kg = @weight_lb * .454,
		st_abbrev = (SELECT abbrev FROM states WHERE name = @state);

SHOW WARNINGS;

SELECT * FROM people_data;

DROP TABLE IF EXISTS people_data;

-- ########################################

-- Ignoring datafile columns
-- a dummy user-defined variable for columns to be ignored (you can
-- use the same variable for all of them)

CREATE TABLE people_data
(
	dt DATETIME,
	last_name CHAR(10),
	first_name CHAR(10),
	weight_kg FLOAT,
	st_abbrev CHAR(2)
);

LOAD DATA LOCAL INFILE 'people.txt' INTO TABLE people_data
	IGNORE 1 LINES
	(@date, @time, @name, @dummy, @state)
	SET dt = CONCAT(@date, ' ', @time),
		first_name = SUBSTRING_INDEX(@name, ' ', 1),
		last_name = SUBSTRING_INDEX(@name, ' ', -1),
		st_abbrev = (SELECT abbrev FROM states WHERE name = @state);

SELECT * FROM people_data;

DROP TABLE IF EXISTS people_data;