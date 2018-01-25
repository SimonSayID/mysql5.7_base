USE `cookbook`;

-- CREATE TABLE ... LIKE does not preserve any DATA DIRECTORY 
-- or INDEX DIRECTORY table options that were specified 
-- for the original table, or any foreign key definitions. 

-- If the original table is a TEMPORARY table, 
-- CREATE TABLE ... LIKE does not preserve TEMPORARY. 
-- To create a TEMPORARY destination table, 
-- use CREATE TEMPORARY TABLE ... LIKE. 

CREATE TABLE pr2 LIKE profile;

DESCRIBE pr2;

INSERT INTO pr2 SELECT * FROM profile WHERE color = 'red';

SELECT * FROM pr2;

DROP TABLE IF EXISTS pr2;

CREATE TABLE pr2 SELECT id, name, color FROM profile;

SELECT * FROM pr2;

DROP TABLE IF EXISTS pr2;

CREATE TABLE pr2
	(
		id INT NOT NULL AUTO_INCREMENT,
		PRIMARY KEY (id)
	)
	SELECT name, color FROM profile;

SELECT * FROM pr2;

DROP TABLE IF EXISTS pr2;
