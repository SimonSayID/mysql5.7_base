USE `cookbook`;

SELECT p2.title 
	FROM painting AS p1 JOIN painting AS p2
	ON p1.a_id = p2.a_id
	WHERE p1.title = 'The Potato Eaters' 
			AND p2.title <> p1.title;

SELECT s2.name, s2.statehood
	FROM states AS s1 JOIN states AS s2
	ON YEAR(s1.statehood) = YEAR(s2.statehood)
	AND s1.name <> s2.name
	WHERE s1.name = 'New York'
	ORDER BY s2.name;


-- Using < rather than <> selects only those rows in which the first 
-- state name is lexically less than the second, and eliminates rows 
-- in which the names appear in opposite order (as well as rows in 
-- which the state names are identical).
SELECT YEAR(s1.statehood) AS year,
	s1.name AS name1, s1.statehood AS statehood1,
	s2.name AS name2, s2.statehood AS statehood2
	FROM states AS s1 JOIN states AS s2
	ON YEAR(s1.statehood) = YEAR(s2.statehood)
	AND s1.name < s2.name
	ORDER BY year, name1, name2;

-- Which states did not join the Union in the same year 
-- as any other state?
SELECT s1.name, s1.statehood
	FROM states AS s1 LEFT JOIN states AS s2
	ON YEAR(s1.statehood) = YEAR(s2.statehood)
	AND s1.name <> s2.name
	WHERE s2.name IS NULL
	ORDER BY s1.name;