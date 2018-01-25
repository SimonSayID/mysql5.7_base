USE `cookbook`;

DROP TABLE IF EXISTS metal;

CREATE TABLE metal (name VARCHAR(20));

INSERT INTO metal (name)
	VALUES
		('gold'),
		('iron'),
		('lead'),
		('mercury'),
		('platinum'),
		('tin')
;

SELECT name FROM metal WHERE name LIKE 'me%';

SELECT name FROM metal WHERE name LIKE '%d';

SELECT name FROM metal WHERE name LIKE '%in%';

SELECT name FROM metal WHERE name LIKE '__at%';

SELECT 'abc' LIKE 'b', 'abc' LIKE '%b%';

SELECT name FROM metal WHERE name NOT LIKE '%i%';

SELECT NULL LIKE '%', NOT NULL LIKE '%';