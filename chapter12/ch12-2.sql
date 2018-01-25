USE `cookbook`;

-- find matches between two tables

-- Joins written with INNER JOIN are inner joins. They produce 
-- a result only for values in one table that match values in 
-- another table.
-- In MySQL, JOIN, CROSS JOIN, and INNER JOIN are syntactic
-- equivalents (they can replace each other). 

-- Cartesian product
SELECT * FROM artist JOIN painting ORDER BY artist.a_id;

-- list the artist paintings
-- method 1
SELECT * FROM artist JOIN painting
	WHERE artist.a_id = painting.a_id
	ORDER BY artist.a_id;

-- method 2
SELECT * FROM artist JOIN painting
	ON artist.a_id = painting.a_id
	ORDER BY artist.a_id;

-- method 3
-- it returns only one instance of each join column, 
-- so a_id appears once
SELECT * FROM artist JOIN painting
	USING (a_id) ORDER BY a_id;

SELECT artist.name, painting.title, painting.state, painting.price
	FROM artist JOIN painting
	ON artist.a_id = painting.a_id
	WHERE painting.state = 'KY';

SELECT artist.name, painting.title, states.name, painting.price
	FROM artist JOIN painting JOIN states
	ON artist.a_id = painting.a_id 
	AND painting.state = states.abbrev
	WHERE painting.state = 'KY';

SELECT painting.title FROM artist JOIN painting 
	ON artist.a_id = painting.a_id
	WHERE artist.name = 'Van Gogh';

SELECT artist.name FROM artist JOIN painting
	ON artist.a_id = painting.a_id
	WHERE painting.title = 'Mona Lisa';

SELECT DISTINCT artist.name FROM artist JOIN painting
	ON artist.a_id = painting.a_id
	WHERE painting.state IN ('KY', 'IN');

SELECT artist.name, COUNT(*) AS 'number of paintings'
	FROM artist JOIN painting ON artist.a_id = painting.a_id
	GROUP BY artist.name;

-- The preceding summary statements produce output only for 
-- those artists in the artist table for whom you actually
-- have acquired paintings.
SELECT artist.name,
	COUNT(*) AS 'number of paintings',
	SUM(painting.price) AS 'total price',
	AVG(painting.price) AS 'average price'
	FROM artist JOIN painting ON artist.a_id = painting.a_id
	GROUP BY artist.name;

-- An outer join can produce those matches as well, but also can 
-- show you which values in one table are missing from the other.
-- RIGHT JOIN result is same as JOIN since there is no monet in
-- painting table. 
SELECT artist.name,
	COUNT(*) AS 'number of paintings',
	SUM(painting.price) AS 'total price',
	AVG(painting.price) AS 'average price'
	FROM artist LEFT JOIN painting ON artist.a_id = painting.a_id
	GROUP BY artist.name;

-- the following query is unambiguous. Each instance of a_id is
-- qualified with the appropriate table name, only artist has a
-- name column, and only painting has title and state columns
SELECT name, title, state FROM artist JOIN painting
	ON artist.a_id = painting.a_id ORDER BY name;

-- short alias
SELECT a.name, p.title, s.name, p.price
	FROM artist AS a JOIN painting AS p JOIN states AS s
	ON a.a_id = p.a_id AND p.state = s.abbrev;

-- Joining Tables from Different Databases
-- SELECT db1.artist.name, db2.painting.title
-- 	FROM db1.artist INNER JOIN db2.painting
-- 	ON db1.artist.a_id = db2.painting.a_id;

-- Table aliases can simplify that considerably:
-- SELECT a.name, p.title
-- 	FROM db1.artist AS a INNER JOIN db2.painting AS p
-- 	ON a.a_id = p.a_id;