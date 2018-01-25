USE `cookbook`;

DROP TABLE IF EXISTS artist;

CREATE TABLE artist
(
	a_id 	INT UNSIGNED NOT NULL AUTO_INCREMENT,
	name	VARCHAR(30) NOT NULL,

	PRIMARY KEY (a_id),
	UNIQUE (name)
);

INSERT INTO artist (name) VALUES
	('Da Vinci'),
	('Monet'),
	('Van Gogh'),
	('Renoir')
;

DROP TABLE IF EXISTS painting;

CREATE TABLE painting
(
	a_id 	INT UNSIGNED NOT NULL,
	p_id 	INT UNSIGNED NOT NULL AUTO_INCREMENT,
	title 	VARCHAR(100) NOT NULL,
	state 	VARCHAR(2) NOT NULL,
	price 	INT UNSIGNED,

	INDEX (a_id),
	PRIMARY KEY (p_id)
);

INSERT INTO painting (a_id, title, state, price)
	SELECT a_id, 'The Last Supper', 'IN', 34
		FROM artist WHERE name = 'Da Vinci';

INSERT INTO painting (a_id, title, state, price)
	SELECT a_id, 'Mona Lisa', 'MI', 87
		FROM artist WHERE name = 'Da Vinci';

INSERT INTO painting (a_id, title, state, price)
	SELECT a_id, 'Starry Night', 'KY', 48
		FROM artist WHERE name = 'Van Gogh';

INSERT INTO painting (a_id,title,state,price)
  	SELECT a_id, 'The Potato Eaters', 'KY', 67
  		FROM artist WHERE name = 'Van Gogh';

INSERT INTO painting (a_id,title,state,price)
  	SELECT a_id, 'Les Deux Soeurs', 'NE', 64
  		FROM artist WHERE name = 'Renoir';

SELECT * FROM artist;

SELECT * FROM painting;