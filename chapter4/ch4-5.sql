USE `cookbook`;

SELECT 'cat' = 'cat', 'cat' = 'dog', 'cat' <> 'cat', 'dog' <> 'cat';

SELECT 'cat' < 'awk', 'cat' < 'dog', 'cat' BETWEEN 'awk' AND 'eel';

SET @s1 = BINARY 'cat', @s2 = BINARY 'CAT';
SELECT @s1 = @s2;

SET @s1 = CONVERT(@s1 USING latin1) COLLATE latin1_swedish_ci;
SET @s2 = CONVERT(@s2 USING latin1) COLLATE latin1_swedish_ci;
SELECT @s1 = @s2;

SET @s1 = _latin1 'cat', @s2 = _latin1 'CAT';
SELECT @s1 = @s2;

SELECT @s1 COLLATE latin1_general_cs = @s2 COLLATE latin1_general_cs 
	AS '@s1 = @s2';

-- If you compare a binary string with a nonbinary string, 
-- the comparison treats both operands as binary strings
SELECT _latin1 'cat' = BINARY 'CAT';

SET @s1 = _latin1 'cat', @s2 = _latin1 'CAT';
SELECT @s1 = @s2, BINARY @s1 = @s2, @s1 = BINARY @s2;

DROP TABLE IF EXISTS news;
CREATE TABLE news
	(
		article BLOB
	);
ALTER TABLE news
	MODIFY article TEXT CHARACTER SET utf8 COLLATE utf8_general_ci;
DROP TABLE news;