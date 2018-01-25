USE `cookbook`;

SELECT t, CONCAT(srcuser, '@', srchost), size FROM mail;

SELECT 
	DATE_FORMAT(t, '%M %e, %Y'),
 	CONCAT(srcuser, '@', srchost),
  	size FROM mail;

SELECT 
	DATE_FORMAT(t, '%M %d, %Y') AS date_sent,
	CONCAT(srcuser, '@', srchost) AS sender,
	size FROM mail;

SELECT 
	DATE_FORMAT(t, '%M %e, %Y') AS date_sent,
	CONCAT(srcuser, '@', srchost) AS sender,
	size/1024 AS kilobytes FROM mail;

SELECT * FROM mail WHERE dstuser = 'tricia' ORDER BY srchost, srcuser;

SELECT * FROM mail WHERE size > 50000 ORDER BY size DESC;

SELECT * FROM mail WHERE size > 50000 ORDER BY size;

SELECT srcuser FROM mail;

SELECT DISTINCT srcuser FROM mail;

SELECT COUNT(DISTINCT srcuser) FROM mail;

SELECT DISTINCT YEAR(t), MONTH(t), DAYOFMONTH(t) FROM mail;

SELECT 
	DATE_FORMAT(t, '%M %d, %Y') AS date_sent,
	CONCAT(srcuser, '@', srchost) AS sender,
	CONCAT(dstuser, '@', dsthost) AS recipient,
	size FROM mail;

DROP VIEW IF EXISTS mail_view;
CREATE VIEW mail_view AS
	SELECT
	DATE_FORMAT(t, '%M %d, %Y') AS date_sent,
	CONCAT(srcuser, '@', srchost) AS sender,
	CONCAT(dstuser, '@', dsthost) AS recipient,
	size FROM mail;

SELECT date_sent, sender, size FROM mail_view
	WHERE size > 100000 ORDER BY size;
