USE `cookbook`;

-- List all the pairings that show each movie and who acted in it
SELECT m.year, m.movie, a.actor
	FROM movies AS m JOIN movies_actors_link AS l 
	JOIN actors AS a
	ON m.id = l.movie_id AND a.id = l.actor_id
	ORDER BY m.year, m.movie, a.actor;

-- List the actors in a given movie
SELECT a.actor 
	FROM movies AS m JOIN movies_actors_link AS l 
	JOIN actors AS a 
	ON m.id = l.movie_id AND a.id = l.actor_id
	WHERE m.movie = 'The Fellowship of the Ring';

-- List the movies in which a given actor has acted
SELECT m.movie
	FROM movies AS m JOIN movies_actors_link AS l 
	JOIN actors AS a 
	ON m.id = l.movie_id AND a.id = l.actor_id
	WHERE a.actor = 'Bruce Willis'
	ORDER BY m.year, m.movie;

