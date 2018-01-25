USE `cookbook`;

DELETE FROM insect;

ALTER TABLE insect
	DROP id,
	ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT FIRST;

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

DELETE FROM insect WHERE id IN (8, 7);

SELECT * FROM insect;

SHOW CREATE TABLE insect\G

-- causes MySQL to reset the sequence counter down as far as
-- it can for new rows
ALTER TABLE insect AUTO_INCREMENT = 1;

INSERT INTO insect (name, date, origin)
	VALUES ('cricket', '2014-09-11', 'basement');

SELECT * FROM insect;

SHOW CREATE TABLE insect\G

DELETE FROM insect WHERE id IN (2, 4, 3, 7);

ALTER TABLE insect AUTO_INCREMENT = 1;

INSERT INTO insect (name, date, origin)
	VALUES ('cricket', '2014-09-11', 'basement');

SELECT * FROM insect;

SHOW CREATE TABLE insect\G