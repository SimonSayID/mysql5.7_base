USE `cookbook`;

DROP TABLE IF EXISTS catalog_list;

CREATE TABLE catalog_list
(
	last_name 	CHAR(40) NOT NULL,
	first_name 	CHAR(40) NOT NULL,
	street 		CHAR(40) NOT NULL
);

INSERT INTO catalog_list (first_name, last_name, street)
	VALUES
		('Jim', 'Isaacson', '515 Fordam St., Apt. 917'),
		('Wallace','Baxter','57 3rd Ave.'),
	    ('Taylor','McTavish','432 River Run'),
	    ('Marlene','Pinter','9 Sunset Trail'),
	    ('WALLACE','BAXTER','57 3rd Ave.'),
	    ('Bartholomew','Brown','432 River Run'),
	    ('Marlene','Pinter','9 Sunset Trail'),
	    ('Wallace','Baxter','57 3rd Ave., Apt 102'),
	    ('Bartholomew','Baxter','52 1rd Ave., Apt 202')
;

-- the DISTINCT count both last_name and first name
SELECT COUNT(DISTINCT last_name, first_name) AS 'distinct names'
	FROM catalog_list;

SELECT COUNT(*), last_name, first_name FROM catalog_list
	GROUP BY first_name, last_name HAVING COUNT(*) > 1;

CREATE TEMPORARY TABLE tmp 
SELECT COUNT(*) AS count, last_name, first_name FROM catalog_list
	GROUP BY first_name, last_name HAVING COUNT(*) > 1;
SELECT catalog_list.* FROM tmp JOIN catalog_list
	USING (last_name, first_name) ORDER BY last_name, first_name;

