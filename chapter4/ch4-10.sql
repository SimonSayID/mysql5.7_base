USE `cookbook`;

SELECT COUNT(*) FROM kjv WHERE MATCH(vtext) AGAINST('hadoram');

SELECT bname, cnum, vnum, LEFT(vtext,65) AS vtext
	FROM kjv WHERE MATCH(vtext) AGAINST('hadoram')\G

SELECT bname, cnum, vnum, LEFT(vtext,65) AS vtext
	FROM kjv WHERE MATCH(vtext) AGAINST('hadoram')
	ORDER BY bnum, cnum, vnum;

SELECT COUNT(*) FROM kjv 
	WHERE MATCH(vtext) AGAINST('Abraham');

SELECT COUNT(*) FROM kjv 
	WHERE MATCH(vtext) AGAINST('Abraham') AND bsect = 'N';

SELECT COUNT(*) FROM kjv
	WHERE MATCH(vtext) AGAINST('Abraham') AND bname = 'Hebrews';

SELECT COUNT(*) FROM kjv
	WHERE MATCH(vtext) AGAINST('ABraham') 
		AND bname = 'Hebrews' AND cnum = 11;


-- If you expect to use search criteria frequently that include other 
-- non- FULLTEXT columns, add regular indexes to those columns 
-- so that queries perform better.

ALTER TABLE kjv ADD INDEX (bnum), ADD INDEX (cnum), ADD INDEX (vnum);

-- Search strings in full-text queries can include more than one word, 
-- and you might suppose that adding words would make a search 
-- more specific. But in fact that widens it because a full-text 
-- search returns rows that contain any of the words. In effect, 
-- the query performs an OR search for any of the words

SELECT COUNT(*) FROM kjv
	WHERE MATCH(vtext) AGAINST('Abraham Sarah');

SELECT COUNT(*) FROM kjv
	WHERE MATCH(vtext) AGAINST('Abraham Sarah Ishmael Isaac');

-- InnoDB doesn’t have this issue
-- the MyISAM full-text indexing engine doesn’t include words less than
-- four characters long
-- add a line to the [mysqld] group of the /etc/
-- my.cnf file to change it
-- [mysqld]
-- ft_min_word_len=3

SELECT COUNT(*) FROM kjv
	WHERE MATCH(vtext) AGAINST('God');

SELECT COUNT(*) FROM kjv
	WHERE MATCH(vtext) AGAINST('sin');

SELECT COUNT(*) FROM kjv
	WHERE MATCH(vtext) AGAINST('David Goliath');

-- rows that contain both words

SELECT COUNT(*) FROM kjv
	WHERE MATCH(vtext) AGAINST('David')
		AND MATCH(vtext) AGAINST('Goliath'); 

-- An easier way to require multiple words is with a Boolean mode search. 
-- To do this, precede each word in the search string with a + character
--  and add IN BOOLEAN MODE after the string

SELECT COUNT(*) FROM kjv
	WHERE MATCH(vtext) AGAINST('+David +Goliath' IN BOOLEAN MODE);

-- Boolean mode searches also permit you to exclude words by preceding 
-- each one with a - character

SELECT COUNT(*) FROM kjv
	WHERE MATCH(vtext) AGAINST('+David -Goliath' IN BOOLEAN MODE);

SELECT COUNT(*) FROM kjv
	WHERE MATCH(vtext) AGAINST('-David +Goliath' IN BOOLEAN MODE);

-- only with a '+' is searched
SELECT COUNT(*) FROM kjv
	WHERE MATCH(vtext) AGAINST('David +Goliath' IN BOOLEAN MODE);

-- * acts as a wildcard operator
-- finds rows containing not only whirl , 
-- but also words such as whirls , whirleth , and whirlwind
SELECT COUNT(*) FROM kjv
	WHERE MATCH(vtext) AGAINST('whirl*' IN BOOLEAN MODE);

-- perform a full-text search for a phrase
-- A phrase match succeeds if a column contains the same words as in 
-- the phrase, in the order specified
SELECT COUNT(*) FROM kjv
	WHERE MATCH(vtext) AGAINST('"still small voice"' IN BOOLEAN MODE);