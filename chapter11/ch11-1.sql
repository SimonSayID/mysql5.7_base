USE `cookbook`;

-- Data type    Maximum unsigned value
-- TINYINT			255
-- SMALLINT		65,535
-- MEDIUMINT		16,777,215
-- INT 			4,294,967,295
-- BIGINT 			18,446,744,073,709,551,615

DROP TABLE IF EXISTS insect;

CREATE TABLE insect
(
	id 		INT UNSIGNED NOT NULL AUTO_INCREMENT,
	name	VARCHAR(30) NOT NULL,
	date	DATE NOT NULL,
	origin	VARCHAR(30) NOT NULL,

	PRIMARY KEY (id)
);

INSERT INTO insect (id, name, date, origin)
	VALUES
		(NULL, 'housefly', '2014-09-10', 'kitchen'),
		(NULL,'millipede','2014-09-10','driveway'),
		(NULL,'grasshopper','2014-09-10','front yard'),
		(NULL,'stink bug','2014-09-10','front yard')
;

INSERT INTO insect (name,date,origin) 
	VALUES
	  ('cabbage butterfly','2014-09-10','garden'),
	  ('ant','2014-09-10','back yard'),
	  ('ant','2014-09-10','back yard'),
	  ('termite','2014-09-10','kitchen woodwork')
;

DELETE FROM insect WHERE id IN (2, 8, 7);

-- For InnoDB or MyISAM tables, values are not reused

SELECT * FROM insect ORDER BY id;

INSERT INTO insect (name, date, origin)
	VALUES ('cricket', '2014-09-11', 'basement');

SELECT LAST_INSERT_ID();

SELECT * FROM insect WHERE id = LAST_INSERT_ID();