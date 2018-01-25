USE `cookbook`;

-- Finding Per-Group Minimum or Maximum Values

-- What is the most expensive painting
-- in the collection, and who painted it?
SET @max_price = (SELECT MAX(price) FROM painting);
SELECT artist.name, painting.title, painting.price
	FROM artist JOIN painting 
	ON painting.a_id = artist.a_id
	WHERE painting.price = @max_price;

-- What is the most expensive painting for each artist?
CREATE TEMPORARY TABLE tmp 
	SELECT a_id, MAX(price) AS max_price 
	FROM painting GROUP BY a_id;
SELECT artist.name, painting.title, painting.price
	FROM artist JOIN painting JOIN tmp
	ON artist.a_id = painting.a_id
	AND painting.a_id = tmp.a_id
	AND painting.price = tmp.max_price;

-- other way
SELECT artist.name, painting.title, painting.price
	FROM artist JOIN painting JOIN
	(SELECT a_id, MAX(price) AS max_price FROM painting
	GROUP BY a_id) AS tmp
	ON painting.a_id = artist.a_id
	AND painting.a_id = tmp.a_id
	AND painting.price = tmp.max_price;

-- the highest-priced painting per artist ID
SELECT p1.a_id, p1.title, p1.price
	FROM painting AS p1 LEFT JOIN painting AS p2
	ON p1.a_id = p2.a_id
	AND p1.price < p2.price
	WHERE p2.a_id IS NULL;

-- display name
SELECT artist.name, p1.title, p1.price
	FROM painting AS p1 LEFT JOIN painting AS p2
	ON p1.a_id = p2.a_id AND p1.price < p2.price
	JOIN artist ON artist.a_id = p1.a_id
	WHERE p2.a_id IS NULL;

-- However, as of MySQL 5.6, the optimizer
-- automatically adds an index to subquery results in the 
-- FROM clause if it estimates that will speed up query 
-- execution. Thus, the disadvantage of the subquery goes 
-- away and you can use it freely without concern over 
-- whether to use the temporary table instead.