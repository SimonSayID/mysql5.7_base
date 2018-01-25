USE `cookbook`;

-- Eliminating Duplicates from a Table

CREATE TABLE IF NOT EXISTS backup_catalog_list
	SELECT * FROM catalog_list;

-- Removing duplicates using table replacement 1
CREATE TABLE tmp LIKE backup_catalog_list;

INSERT INTO tmp SELECT DISTINCT * FROM catalog_list;

SELECT * FROM tmp ORDER BY last_name, first_name;

DROP TABLE catalog_list;

RENAME TABLE tmp TO catalog_list;

-- Removing duplicates using table replacement 2
CREATE TABLE tmp LIKE backup_catalog_list;

ALTER TABLE tmp ADD PRIMARY KEY (last_name, first_name);

INSERT IGNORE INTO tmp SELECT * FROM catalog_list;

SELECT * FROM tmp ORDER BY last_name, first_name;

DROP TABLE catalog_list;

RENAME TABLE tmp TO catalog_list;

-- Removing duplicates of a particular row

DROP TABLE IF EXISTS backup_catalog_list_2;

CREATE TABLE backup_catalog_list_2
	SELECT * FROM backup_catalog_list;

SELECT COUNT(*), last_name, first_name FROM backup_catalog_list_2
	GROUP BY last_name, first_name HAVING COUNT(*) > 1;

DELETE FROM backup_catalog_list_2 
	WHERE last_name = 'Baxter' AND first_name = 'Wallace'
	LIMIT 2;

DELETE FROM backup_catalog_list_2
	WHERE last_name = 'Pinter' AND first_name = 'Marlene'
	LIMIT 1;

SELECT * FROM backup_catalog_list_2;

-- In general, using DELETE ... LIMIT n is likely to be slower 
-- than removing duplicates by using a second table or by adding
-- a unique index. Those methods keep the data on the server 
-- side and let the server do all the work. DELETE ... LIMIT n 
-- involves a lot of client-server interaction because it uses 
-- a SELECT statement to retrieve information about duplicates, 
-- followed by several DELETE statements to remove instances of 
-- duplicated rows. Also, this technique does not prevent 
-- duplicates from occurring in the future.