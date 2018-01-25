USE `cookbook`;

-- Generating Random Numbers

-- MySQL has a RAND() function that produces
-- random numbers between 0 and 1
SELECT RAND(), RAND(), RAND();

SELECT RAND(), RAND(10), RAND(20);

SELECT RAND(), RAND(10), RAND(20);

-- When invoked with an integer argument, RAND() uses that
-- value to seed the random number generator. You can use 
-- this feature to produce a repeatable series of numbers
-- for a column of a query result.

-- Randomizing a Set of Rows
SELECT * FROM artist ORDER BY a_id;

SELECT * FROM artist ORDER BY RAND();

SELECT * FROM artist ORDER BY RAND();

-- Selecting Random Items from a Set of Rows
SELECT * FROM artist ORDER BY RAND() LIMIT 1;

-- mush faster when table is large 
-- (1-4 must be unbroken sequence)
SET @id = FLOOR(RAND()*4)+1;
SELECT * FROM artist WHERE a_id = @id;