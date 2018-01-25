USE `cookbook`;

-- Binary data type Nonbinary data type maximum length
-- BINARY 	           CHAR 		 		255
-- VARBINARY           VARCHAR 	 			65,535
-- TINYBLOB            TINYTEXT 	 		255
-- BLOB                TEXT 		 		65,535
-- MEDIUMBLOB          MEDIUMTEXT 			16,777,215
-- LONGBLOB            LONGTEXT   			4,294,967,295

DROP TABLE IF EXISTS t;
CREATE TABLE t (c1 CHAR(10), c2 VARCHAR(10));
INSERT INTO t (c1, c2) VALUES('abc        ', 'abc       ');
SELECT c1, c2, CHAR_LENGTH(c1), CHAR_LENGTH(c2) FROM t;

SELECT USER(), CHARSET(USER()), COLLATION(USER());

SET NAMES 'latin1';
SELECT CHARSET('abc'), COLLATION('abc');

SET NAMES utf8 COLLATE 'utf8_bin';
SELECT CHARSET('abc'), COLLATION('abc');

SET @s1 = _latin1 'my string', @s2 = CONVERT(@s1 USING utf8);
SELECT CHARSET(@s1), CHARSET(@s2);

SET @s1 = _latin1 'my string', @s2 = @s1 COLLATE latin1_spanish_ci;
SELECT COLLATION(@s1), COLLATION(@s2);

SET @s1 = _latin1 'my string';
SET @s2 = CONVERT(@s1 USING binary);
SET @s3 = CONVERT(@s2 USING utf8);
SELECT CHARSET(@s1), CHARSET(@s2), CHARSET(@s3);

SELECT CHARSET(BINARY _latin1 'my string');