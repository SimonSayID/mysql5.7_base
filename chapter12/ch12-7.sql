USE `cookbook`;

DROP TABLE IF EXISTS movies_actors;

CREATE TABLE movies_actors
(
	year 	YEAR NOT NULL,
	movie 	VARCHAR(80) NOT NULL,
	actor 	VARCHAR(60) NOT NULL
);

INSERT INTO movies_actors (year, movie, actor)
	VALUES
		(2005, 'Kingdom of Heaven', 'Liam Neeson'),
		(2005,'Kingdom of Heaven','Orlando Bloom'),
		(1997,'The Fifth Element','Bruce Willis'),
		(1997,'The Fifth Element','Gary Oldman'),
		(1997,'The Fifth Element','Ian Holm'),
		(1999,'The Phantom Menace','Ewan McGregor'),
		(1999,'The Phantom Menace','Liam Neeson'),
		(2001,'The Fellowship of the Ring','Ian McKellen'),
		(2001,'The Fellowship of the Ring','Ian Holm'),
		(2001,'The Fellowship of the Ring','Orlando Bloom'),
		(2001,'The Fellowship of the Ring','Elijah Wood'),
		(2010,'Red','Helen Mirren'),
		(2010,'Red','Bruce Willis'),
		(2011,'Unknown','Diane Kruger'),
		(2011,'Unknown','Liam Neeson')
;

DROP TABLE IF EXISTS movies;

CREATE TABLE movies
(
	id 		INT UNSIGNED NOT NULL AUTO_INCREMENT,
	year 	YEAR NOT NULL,
	movie 	VARCHAR(80) NOT NULL,
	PRIMARY KEY (id)
);

INSERT INTO movies (year, movie)
	SELECT DISTINCT year, movie FROM movies_actors
	ORDER BY year, movie;


DROP TABLE IF EXISTS actors;

CREATE TABLE actors
(
	id 		INT UNSIGNED NOT NULL AUTO_INCREMENT,
	actor 	VARCHAR(60) NOT NULL,
	PRIMARY KEY (id)
);

INSERT INTO actors (actor)
	SELECT DISTINCT actor FROM movies_actors
	ORDER BY actor;

DROP TABLE IF EXISTS movies_actors_link;

CREATE TABLE movies_actors_link
(
	movie_id 	INT UNSIGNED NOT NULL,
	actor_id 	INT UNSIGNED NOT NULL,
	UNIQUE (movie_id, actor_id)
);

INSERT INTO movies_actors_link (movie_id, actor_id)
	SELECT movies.id, actors.id
	FROM movies_actors JOIN movies JOIN actors
	WHERE movies_actors.movie = movies.movie
	AND movies_actors.actor = actors.actor;

SELECT * FROM movies_actors;

SELECT * FROM movies;

SELECT * FROM actors;

SELECT * FROM movies_actors_link;