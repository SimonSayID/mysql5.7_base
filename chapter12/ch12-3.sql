USE `cookbook`;

-- Finding Mismatches Between Tables
SELECT artist.* FROM artist LEFT JOIN painting
	ON artist.a_id = painting.a_id
	WHERE painting.a_id IS NULL;

-- other way
SELECT * FROM artist WHERE a_id NOT IN 
	(SELECT a_id FROM painting);

-- The following statement lists each artist from the artist
-- table and shows whether you have any paintings by the artist
SELECT artist.name,
	IF(COUNT(painting.a_id)>0, 'yes', 'no') AS 'in collection?'
	FROM artist LEFT JOIN painting ON artist.a_id = painting.a_id
	GROUP BY artist.name;

-- In the special case that you want to base the comparison on 
-- every column that appears in both tables, you can use 
-- NATURAL LEFT JOIN or NATURAL RIGHT JOIN and omit the ON
-- or USING clause:
-- SELECT * FROM t1 NATURAL LEFT JOIN t2;
-- SELECT * FROM t1 NATURAL RIGHT JOIN t2;

