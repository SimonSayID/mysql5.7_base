USE `cookbook`;

SELECT srcuser, COUNT(*) FROM mail GROUP BY srcuser;

SELECT srcuser,
	SUM(size) AS 'total bytes',
	AVG(size) AS 'bytes per message'
	FROM mail GROUP BY srcuser;

-- To be more specific and find out how many messages each sender
-- sent from each host, use two grouping columns.
SELECT srcuser, srchost, COUNT(srcuser) FROM mail
	GROUP BY srcuser, srchost;

-- displaying for each the size of the largest message sent and the
-- date of the most recent message
SELECT srcuser, MAX(size), MAX(t) FROM mail GROUP BY srcuser;

-- This query finds the size of the largest message sent between
-- each pair of sender and recipient values listed in the mail table
SELECT srcuser, dstuser, MAX(size) FROM mail
	GROUP BY srcuser, dstuser;

CREATE TEMPORARY TABLE t 
	SELECT name, MAX(miles) AS miles FROM driver_log
	GROUP BY name;
SELECT d.name, d.trav_date, d.miles AS 'longest trip'
	FROM driver_log AS d JOIN t USING (name, miles) ORDER BY name;