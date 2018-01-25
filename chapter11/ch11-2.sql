USE `cookbook`;


-- renumber the id values in the insect table
SELECT * FROM insect ORDER BY id;

ALTER TABLE insect DROP id;

SHOW CREATE TABLE insect\G

ALTER TABLE insect 
	ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT FIRST,
	ADD PRIMARY KEY (id);

SHOW CREATE TABLE insect\G

SELECT * FROM insect ORDER BY id;

-- One problem with resequencing a column using separate 
-- ALTER TABLE statements is that the table is without that
-- column for the interval between the two operations. This 
-- might cause difficulties for other clients that try 
-- to access the table during that time.

DELETE FROM insect WHERE id in (2, 5, 1);

SELECT * FROM insect ORDER BY id;

-- better approach

-- The difference is that it is unnecessary to reestablish the
-- PRIMARY KEY : MySQL doesn’t drop it unless the indexed column
-- is missing after all the actions specified in the ALTER TABLE
-- statement have been performed.

ALTER TABLE insect
	DROP id,
	ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT FIRST;

SHOW CREATE TABLE insect\G

SELECT * FROM insect ORDER BY id;