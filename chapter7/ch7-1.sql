USE `cookbook`;

DROP TABLE IF EXISTS states;

CREATE TABLE states
(
	name 		VARCHAR(30) NOT NULL,
	abbrev		CHAR(2) NOT NULL,
	statehood	DATE,
	pop			BIGINT,
	PRIMARY KEY (abbrev)
);

LOAD DATA LOCAL INFILE 'states.txt' INTO TABLE states;